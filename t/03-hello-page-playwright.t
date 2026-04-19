use strict;
use warnings FATAL => 'all';

use File::Spec;
use File::Temp qw(tempfile);
use IO::Socket::INET;
use Test::More;
use Time::HiRes qw(sleep);

use lib 'lib';
use Say::Web;

my $node_bin = _find_command('node');
my $chromium_bin = $ENV{CHROMIUM_BIN} || _find_command(qw(chromium chromium-browser google-chrome google-chrome-stable));

plan skip_all => 'Playwright browser test requires node and Chromium'
  if !$node_bin || !$chromium_bin;

my $port = _reserve_port();
my $pid = fork();
die "Unable to fork test server: $!" if !defined $pid;

if ( $pid == 0 ) {
    _run_server($port);
    exit 0;
}

eval {
    _wait_for_port($port);
    my ( $fh, $script_path ) = tempfile( 'say-playwright-XXXXXX', SUFFIX => '.js', TMPDIR => 1 );
    print {$fh} _playwright_script();
    close $fh or die "Unable to close Playwright script: $!";

    my $output = qx{NODE_PATH="$ENV{NODE_PATH}" CHROMIUM_BIN="$chromium_bin" SAY_URL="http://127.0.0.1:$port/app/say/hello" "$node_bin" "$script_path" 2>&1};
    my $exit = $? >> 8;
    is( $exit, 0, "Playwright verifies /app/say/hello\n$output" );
};
my $error = $@;

kill 'TERM', $pid;
waitpid $pid, 0;

die $error if $error;

done_testing();

sub _run_server {
    my ($port) = @_;
    my $server = IO::Socket::INET->new(
        LocalAddr => '127.0.0.1',
        LocalPort => $port,
        Listen    => 5,
        Proto     => 'tcp',
        ReuseAddr => 1,
    ) or die "Unable to start server: $!";

    local $SIG{TERM} = sub { exit 0 };
    local $SIG{PIPE} = 'IGNORE';

    while ( my $client = $server->accept ) {
        my $request = <$client>;
        my $path = '/';
        if ( defined $request && $request =~ m{\AGET\s+(\S+) } ) {
            $path = $1;
        }

        while ( defined( my $line = <$client> ) ) {
            last if $line =~ /^\r?\n\z/;
        }

        my $response = Say::Web::handle(
            path       => $path,
            skill_root => '.',
        );

        my %headers = @{ $response->[1] };
        print {$client} "HTTP/1.1 $response->[0] " . ( $response->[0] == 200 ? "OK" : "Not Found" ) . "\r\n";
        print {$client} "Content-Type: $headers{'Content-Type'}\r\n";
        print {$client} "Content-Length: " . length( $response->[2] ) . "\r\n";
        print {$client} "Connection: close\r\n\r\n";
        print {$client} $response->[2];
        close $client;
    }
}

sub _wait_for_port {
    my ($port) = @_;
    for ( 1 .. 50 ) {
        my $socket = IO::Socket::INET->new(
            PeerAddr => '127.0.0.1',
            PeerPort => $port,
            Proto    => 'tcp',
        );
        if ($socket) {
            close $socket;
            return 1;
        }
        sleep 0.1;
    }
    die "Timed out waiting for port $port";
}

sub _reserve_port {
    my $socket = IO::Socket::INET->new(
        LocalAddr => '127.0.0.1',
        LocalPort => 0,
        Listen    => 1,
        Proto     => 'tcp',
        ReuseAddr => 1,
    ) or die "Unable to reserve port: $!";
    my $port = $socket->sockport;
    close $socket;
    return $port;
}

sub _find_command {
    for my $candidate (@_) {
        my $path = qx{command -v $candidate 2>/dev/null};
        chomp $path;
        return $path if $path;
    }
    return;
}

sub _playwright_script {
    return <<'JS';
const { chromium } = require('playwright-core');

(async () => {
  const browser = await chromium.launch({
    executablePath: process.env.CHROMIUM_BIN,
    headless: true
  });
  const page = await browser.newPage();
  await page.goto(process.env.SAY_URL, { waitUntil: 'networkidle' });
  const heading = await page.textContent('h1');
  const title = await page.title();
  if (heading !== 'Hello World') {
    throw new Error(`Unexpected heading: ${heading}`);
  }
  if (title !== 'Hello World') {
    throw new Error(`Unexpected title: ${title}`);
  }
  await browser.close();
})();
JS
}
