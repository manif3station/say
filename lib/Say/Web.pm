package Say::Web;

use strict;
use warnings;

use File::Spec;

sub handle {
    my (%args) = @_;
    my $path = $args{path} // '/';
    my $root = $args{skill_root} // '.';

    if ( $path eq '/app/say/hello' ) {
        my $page = _load_page(
            File::Spec->catfile( $root, 'dashboards', 'hello' )
        );
        my $html = _render_document($page);
        return [
            200,
            [ 'Content-Type' => 'text/html; charset=utf-8' ],
            $html,
        ];
    }

    return [
        404,
        [ 'Content-Type' => 'text/plain; charset=utf-8' ],
        "Not Found\n",
    ];
}

sub _load_page {
    my ($path) = @_;
    open my $fh, '<', $path or die "Unable to read $path: $!";
    local $/;
    my $content = <$fh>;
    close $fh or die "Unable to close $path: $!";
    return _parse_page($content);
}

sub _parse_page {
    my ($content) = @_;
    my ($title) = $content =~ /^TITLE:\s*(.+)$/m;
    my ($body)  = $content =~ /^HTML:\n([\s\S]*)\z/m;

    die "Missing page title\n" if !defined $title;
    die "Missing page body\n"  if !defined $body;

    return {
        title => $title,
        body  => $body,
    };
}

sub _render_document {
    my ($page) = @_;
    return join '',
      "<!doctype html>\n",
      "<html lang=\"en\">\n",
      "<head><meta charset=\"utf-8\"><title>",
      $page->{title},
      "</title></head>\n",
      "<body>\n",
      $page->{body},
      "\n</body>\n",
      "</html>\n";
}

1;
