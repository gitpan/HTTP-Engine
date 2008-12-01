package HTTP::Engine::Role::RequestBuilder::Standard;
use Shika::Role;

use Socket qw[AF_INET inet_aton];

with qw(HTTP::Engine::Role::RequestBuilder);

sub _build_cookies {
    my($self, $req) = @_;

    if (my $header = $req->header('Cookie')) {
        HTTP::Engine::Util::require_once('CGI/Simple/Cookie.pm');
        return { CGI::Simple::Cookie->parse($header) };
    } else {
        return {};
    }
}

sub _build_hostname {
    my ( $self, $req ) = @_;
    gethostbyaddr( inet_aton( $req->address ), AF_INET );
}

1;
