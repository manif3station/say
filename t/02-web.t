use strict;
use warnings;

use Test::More;

use lib 'lib';
use Say::Web;

my $response = Say::Web::handle(
    path       => '/app/say/hello',
    skill_root => '.',
);

is( $response->[0], 200, 'hello route returns success' );
is( $response->[1][1], 'text/html; charset=utf-8', 'hello route returns html content type' );
like( $response->[2], qr/<title>Hello World<\/title>/, 'hello route renders the page title' );
like( $response->[2], qr/<h1>Hello World<\/h1>/, 'hello route renders the page heading' );

my $missing = Say::Web::handle(
    path       => '/app/say/missing',
    skill_root => '.',
);

is( $missing->[0], 404, 'missing route returns not found' );
is( $missing->[2], "Not Found\n", 'missing route returns plain text not found body' );

done_testing();

