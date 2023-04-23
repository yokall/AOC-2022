#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use BeaconExclusionZone::ExclusionZone;

subtest 'covers_row' => sub {
    my $exclusion_zone = BeaconExclusionZone::ExclusionZone->new(
        min_x => -1,
        max_x => 17,
        min_y => -2,
        max_y => 16,
    );

    ok( $exclusion_zone->covers_row(10),
        'should return true if it spans the given y index' );
    ok( !$exclusion_zone->covers_row(20),
        'should return false if it does not spans the given y index' );
};

done_testing();
