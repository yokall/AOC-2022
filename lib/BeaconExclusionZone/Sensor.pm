package BeaconExclusionZone::Sensor;

use strict;
use warnings;

use Moose;

use BeaconExclusionZone::ExclusionZone;
use Common::Position;

has 'position' => (
    is  => 'ro',
    isa => 'Common::Position',
);

has 'closest_beacon_position' => (
    is  => 'ro',
    isa => 'Common::Position',
);

has 'beacon_exclusion_zone' => (
    is      => 'ro',
    isa     => 'BeaconExclusionZone::ExclusionZone',
    lazy    => 1,
    builder => '_build_beacon_exclusion_zone'
);

sub _build_beacon_exclusion_zone {
    my $self = shift;

    my $manhatton_distance =
      abs( $self->position->x - $self->closest_beacon_position->x ) +
      abs( $self->position->y - $self->closest_beacon_position->y );

    return BeaconExclusionZone::ExclusionZone->new(
        min_x => $self->position->x - $manhatton_distance,
        max_x => $self->position->x + $manhatton_distance,
        min_y => $self->position->y - $manhatton_distance,
        max_y => $self->position->y + $manhatton_distance
    );
}

1;
