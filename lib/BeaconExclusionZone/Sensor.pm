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

sub new_from_input_text {
    my ( $self, $input_text ) = @_;

    my $sensor_x;
    my $sensor_y;
    my $beacon_x;
    my $beacon_y;

    if ( $input_text =~
/Sensor at x=(-*\d+), y=(-*\d+): closest beacon is at x=(-*?\d+), y=(-*\d+)/
      )
    {
        $sensor_x = $1;
        $sensor_y = $2;
        $beacon_x = $3;
        $beacon_y = $4;
    }
    else {
        die "Input text didn't match format: '$input_text'";
    }

    return BeaconExclusionZone::Sensor->new(
        position => Common::Position->new( x => $sensor_x, y => $sensor_y ),
        closest_beacon_position =>
          Common::Position->new( x => $beacon_x, y => $beacon_y )
    );
}

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
