#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use RopeBridge::PositionCalculator;

subtest 'get_touching_positions' => sub {
    subtest
        'should return all points directly around a point including diagonally'
        => sub {
        my $x = 1;
        my $y = 1;

        my $actual
            = RopeBridge::PositionCalculator::get_touching_positions( $x,
            $y );

        my $expected = [
            RopeBridge::Position->new( x => 1, y => 1 ),
            RopeBridge::Position->new( x => 0, y => 0 ),
            RopeBridge::Position->new( x => 1, y => 0 ),
            RopeBridge::Position->new( x => 2, y => 0 ),
            RopeBridge::Position->new( x => 0, y => 1 ),
            RopeBridge::Position->new( x => 2, y => 1 ),
            RopeBridge::Position->new( x => 0, y => 2 ),
            RopeBridge::Position->new( x => 1, y => 2 ),
            RopeBridge::Position->new( x => 2, y => 2 ),
        ];

        is( $actual, $expected );
        };
};

done_testing();
