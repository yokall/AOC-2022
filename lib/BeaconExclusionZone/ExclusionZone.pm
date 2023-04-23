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

sub excluded_positions_for_row {
    my ( $self, $y ) = @_;

    my $y_midpoint = $self->min_y + ( ( $self->max_y - $self->min_y ) / 2 );

    my $y_offset = abs( $y - $y_midpoint );

    my @range = ( $self->min_x + $y_offset ) .. ( $self->max_x - $y_offset );

    return \@range;
}

1;
