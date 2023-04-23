package BeaconExclusionZone::ExclusionZone;

use strict;
use warnings;

use Moose;

has 'min_x' => (
    is  => 'ro',
    isa => 'Int',
);

has 'max_x' => (
    is  => 'ro',
    isa => 'Int',
);

has 'min_y' => (
    is  => 'ro',
    isa => 'Int',
);

has 'max_y' => (
    is  => 'ro',
    isa => 'Int',
);

sub covers_row {
    my ( $self, $y ) = @_;

    return ( $y >= $self->min_y && $y <= $self->max_y );
}

1;
