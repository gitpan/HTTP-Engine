package HTTP::Engine::Response;

use strict;
use warnings;
use base qw( HTTP::Response Class::Accessor::Fast );

__PACKAGE__->mk_accessors(qw/body context cookies location status protocol/);

*output = \&body;

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new(@_);

    $self->{body}     = '';
    $self->{cookies}  = {};
    $self->{status}   = 200;
    $self->{protocol} = '1.0';

    $self;
}

sub content_encoding { shift->headers->content_encoding(@_) }
sub content_length   { shift->headers->content_length(@_) }
sub content_type     { shift->headers->content_type(@_) }
sub header           { shift->headers->header(@_) }

sub redirect {
    my $self = shift;

    if (@_) {
        $self->location( shift );
        $self->status( shift || 302 );
    }

    $self->location;
}

sub set_http_response {
    my ($self, $res) = @_;
    $self->status( $res->code );
    $self->{_headers} = $res->headers; # ad hoc
    $self->body( $res->content );
    $self;
}

1;
