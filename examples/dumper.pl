use strict;
use warnings;
use lib 'lib';
use Data::Dumper;

use HTTP::Engine;
use String::TT qw( tt );

HTTP::Engine->new(
    interface => {
        module => 'ServerSimple',
        args   => {
            host => '0.0.0.0',
            port => 14000,
        },
        request_handler => 'handle_request',
    },
)->run;

sub handle_request {
    my $c = shift;
    my $req_dump = Dumper($c->req);
    my $raw = $c->req->raw_body;
    my $body = tt '
        <form method="get">
            <input type="text" name="foo-get" />
            <input type="submit" />
        </form>
        <form method="post">
            <input type="text" name="foo-post" />
            <input type="submit" />
        </form>

        <form method="post" enctype="multipart/form-data">
            <input type="file" name="upload_file" />
            <input type="submit" />
        </form>

        <pre>[% raw | html -%]</pre>
        <pre>[% req_dump | html -%]</pre>
';

    $c->res->body($body);
}

