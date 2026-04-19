use strict;
use warnings;

use Test::More;

use lib 'lib';
use Say::Hello;

is( Say::Hello::render(), "hello\n", 'module renders hello output' );

my $output = qx{$^X cli/hello};
my $exit = $? >> 8;

is( $exit, 0, 'cli/hello exits cleanly' );
is( $output, "hello\n", 'cli/hello prints hello' );

done_testing();
