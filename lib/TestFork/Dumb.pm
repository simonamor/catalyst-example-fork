package TestFork::Dumb;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {
        lockval => 0,
    };
    bless $self, $class;

    warn "here " . scalar($self);

    return $self;
}

sub locked {
    my $self = shift;
    warn "here " . scalar($self);
    return $self->{ lockval };
}

sub set_lock {
    my $self = shift;
    warn "here " . scalar($self);
    $self->{ lockval } = 1;
}

sub clear_lock {
    my $self = shift;
    warn "here " . scalar($self);
    $self->{ lockval } = 0;
}

1;
