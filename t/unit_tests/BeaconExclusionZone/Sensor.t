#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use BeaconExclusionZone::Sensor;
use Common::Position;

subtest 'new' => sub {
    my $sensor = BeaconExclusionZone::Sensor->new(
        position                => Common::Position->new( x => 8, y => 7 ),
        closest_beacon_position => Common::Position->new( x => 2, y => 10 )
    );

    is( $sensor->beacon_exclusion_zone->min_x,
        -1, 'should calculate minimum x value of beacon exclusion area' );
    is( $sensor->beacon_exclusion_zone->max_x,
        17, 'should calculate maximum x value of beacon exclusion area' );
    is( $sensor->beacon_exclusion_zone->min_y,
        -2, 'should calculate minimum y value of beacon exclusion area' );
    is( $sensor->beacon_exclusion_zone->max_y,
        16, 'should calculate maximum y value of beacon exclusion area' );
};

done_testing();
