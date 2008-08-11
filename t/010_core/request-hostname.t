use strict;
use warnings;
use Test::More;
use HTTP::Engine::Request;
use HTTP::Engine::RequestBuilder;

plan tests => 2;

# get hostname by REMOTE_HOST
$ENV{REMOTE_HOST} = "mudage.example.com";
is _get(), "mudage.example.com";

# get hostname by REMOTE_ADDR
$ENV{REMOTE_HOST} = '';
$ENV{REMOTE_ADDR} = "127.0.0.1";
ok _get();

sub _get {
    HTTP::Engine::Request->new(
        request_builder => HTTP::Engine::RequestBuilder->new,
    )->hostname;
}
