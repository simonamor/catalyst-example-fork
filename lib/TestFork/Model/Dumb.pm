package TestFork::Model::Dumb;

use base 'Catalyst::Model::Adaptor';

use strict;
use warnings;

use Moose;

has 'DumbInstance' => (
    is => 'rw',
    isa => 'TestFork::Dumb',
);

__PACKAGE__->config( class => "TestFork::Dumb" );

#our $AUTOLOAD;
#
#sub AUTOLOAD {
#    my $self = shift;
#    my $name = $AUTOLOAD;
#    $name =~ s/.*://;
#    $self->DumbInstance->$name(@_);
#}

1;
