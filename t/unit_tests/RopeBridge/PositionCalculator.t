#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use RopeBridge::PositionCalculator;

subtest 'touching' => sub {
    subtest 'should return true if positions are' => sub {
        my $expected = 1;

        subtest 'the same' => sub {
            my $position1 = RopeBridge::Position->new( x => 1, y => 1 );
            my $position2 = RopeBridge::Position->new( x => 1, y => 1 );

            my $actual
                = RopeBridge::PositionCalculator::touching( $position1,
                $position2 );

            is( $actual, $expected );
        };

        subtest 'adjacent including diagonally' => sub {
            my $position1 = RopeBridge::Position->new( x => 1, y => 1 );
            my $position2 = RopeBridge::Position->new( x => 2, y => 2 );

            my $actual
                = RopeBridge::PositionCalculator::touching( $position1,
                $position2 );

            is( $actual, $expected );
        };
    };

    subtest 'should return false if positions are not adjacent' => sub {
        my $position1 = RopeBridge::Position->new( x => 1, y => 1 );
        my $position2 = RopeBridge::Position->new( x => 3, y => 1 );

        my $actual
            = RopeBridge::PositionCalculator::touching( $position1,
            $position2 );

        my $expected = 0;

        is( $actual, $expected );
    };
};

done_testing();
