#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use RopeBridge::Move;
use RopeBridge::Position;

subtest 'execute' => sub {
    subtest 'should not move the tail if it is still touching the head' =>
        sub {
        my $head_position = RopeBridge::Position->new( x => 0, y => 0 );
        my $tail_position = RopeBridge::Position->new( x => 0, y => 0 );

        my $positions = [ $head_position, $tail_position, ];

        my $new_positions = RopeBridge::Move::execute( $positions, 'R' );

        is( $new_positions->[0],
            RopeBridge::Position->new( x => 1, y => 0 ) );
        is( $new_positions->[1], $tail_position );
        };

    subtest 'should move the tail if it is not touching the head' => sub {
        subtest 'head to the right 2 spaces' => sub {
            my $head_position = RopeBridge::Position->new( x => 1, y => 0 );
            my $tail_position = RopeBridge::Position->new( x => 0, y => 0 );

            my $positions = [ $head_position, $tail_position, ];

            my $new_positions = RopeBridge::Move::execute( $positions, 'R' );

            is( $new_positions->[0],
                RopeBridge::Position->new( x => 2, y => 0 ) );
            is( $new_positions->[1],
                RopeBridge::Position->new( x => 1, y => 0 ) );
        };

        subtest 'head to the left 2 spaces' => sub {
            my $head_position = RopeBridge::Position->new( x => 1, y => 0 );
            my $tail_position = RopeBridge::Position->new( x => 2, y => 0 );

            my $positions = [ $head_position, $tail_position, ];

            my $new_positions = RopeBridge::Move::execute( $positions, 'L' );

            is( $new_positions->[0],
                RopeBridge::Position->new( x => 0, y => 0 ) );
            is( $new_positions->[1],
                RopeBridge::Position->new( x => 1, y => 0 ) );
        };

        subtest 'head 2 spaces above' => sub {
            my $head_position = RopeBridge::Position->new( x => 0, y => 1 );
            my $tail_position = RopeBridge::Position->new( x => 0, y => 2 );

            my $positions = [ $head_position, $tail_position, ];

            my $new_positions = RopeBridge::Move::execute( $positions, 'U' );

            is( $new_positions->[0],
                RopeBridge::Position->new( x => 0, y => 0 ) );
            is( $new_positions->[1],
                RopeBridge::Position->new( x => 0, y => 1 ) );
        };

        subtest 'head 2 spaces below' => sub {
            my $head_position = RopeBridge::Position->new( x => 0, y => 1 );
            my $tail_position = RopeBridge::Position->new( x => 0, y => 0 );

            my $positions = [ $head_position, $tail_position, ];

            my $new_positions = RopeBridge::Move::execute( $positions, 'D' );

            is( $new_positions->[0],
                RopeBridge::Position->new( x => 0, y => 2 ) );
            is( $new_positions->[1],
                RopeBridge::Position->new( x => 0, y => 1 ) );
        };

        subtest 'head to the right 1 space and down 2 spaces' => sub {
            my $head_position = RopeBridge::Position->new( x => 1, y => 1 );
            my $tail_position = RopeBridge::Position->new( x => 0, y => 0 );

            my $positions = [ $head_position, $tail_position, ];

            my $new_positions = RopeBridge::Move::execute( $positions, 'D' );

            is( $new_positions->[0],
                RopeBridge::Position->new( x => 1, y => 2 ) );
            is( $new_positions->[1],
                RopeBridge::Position->new( x => 1, y => 1 ) );
        };

        subtest 'head to the right 1 space and up 2 spaces' => sub {
            my $head_position = RopeBridge::Position->new( x => 1, y => 1 );
            my $tail_position = RopeBridge::Position->new( x => 0, y => 2 );

            my $positions = [ $head_position, $tail_position, ];

            my $new_positions = RopeBridge::Move::execute( $positions, 'U' );

            is( $new_positions->[0],
                RopeBridge::Position->new( x => 1, y => 0 ) );
            is( $new_positions->[1],
                RopeBridge::Position->new( x => 1, y => 1 ) );
        };

        subtest 'head to the right 2 spaces and down 1 space' => sub {
            my $head_position = RopeBridge::Position->new( x => 1, y => 1 );
            my $tail_position = RopeBridge::Position->new( x => 0, y => 0 );

            my $positions = [ $head_position, $tail_position, ];

            my $new_positions = RopeBridge::Move::execute( $positions, 'R' );

            is( $new_positions->[0],
                RopeBridge::Position->new( x => 2, y => 1 ) );
            is( $new_positions->[1],
                RopeBridge::Position->new( x => 1, y => 1 ) );
        };

        subtest 'head to the right 2 spaces and up 1 space' => sub {
            my $head_position = RopeBridge::Position->new( x => 1, y => 1 );
            my $tail_position = RopeBridge::Position->new( x => 0, y => 2 );

            my $positions = [ $head_position, $tail_position, ];

            my $new_positions = RopeBridge::Move::execute( $positions, 'R' );

            is( $new_positions->[0],
                RopeBridge::Position->new( x => 2, y => 1 ) );
            is( $new_positions->[1],
                RopeBridge::Position->new( x => 1, y => 1 ) );
        };

        subtest 'head to the left 1 space and down 2 spaces' => sub {
            my $head_position = RopeBridge::Position->new( x => 0, y => 1 );
            my $tail_position = RopeBridge::Position->new( x => 1, y => 0 );

            my $positions = [ $head_position, $tail_position, ];

            my $new_positions = RopeBridge::Move::execute( $positions, 'D' );

            is( $new_positions->[0],
                RopeBridge::Position->new( x => 0, y => 2 ) );
            is( $new_positions->[1],
                RopeBridge::Position->new( x => 0, y => 1 ) );
        };

        subtest 'head to the left 1 space and up 2 spaces' => sub {
            my $head_position = RopeBridge::Position->new( x => 0, y => 1 );
            my $tail_position = RopeBridge::Position->new( x => 1, y => 2 );

            my $positions = [ $head_position, $tail_position, ];

            my $new_positions = RopeBridge::Move::execute( $positions, 'U' );

            is( $new_positions->[0],
                RopeBridge::Position->new( x => 0, y => 0 ) );
            is( $new_positions->[1],
                RopeBridge::Position->new( x => 0, y => 1 ) );
        };

        subtest 'head to the left 2 spaces and down 1 space' => sub {
            my $head_position = RopeBridge::Position->new( x => 1, y => 1 );
            my $tail_position = RopeBridge::Position->new( x => 2, y => 0 );

            my $positions = [ $head_position, $tail_position, ];

            my $new_positions = RopeBridge::Move::execute( $positions, 'L' );

            is( $new_positions->[0],
                RopeBridge::Position->new( x => 0, y => 1 ) );
            is( $new_positions->[1],
                RopeBridge::Position->new( x => 1, y => 1 ) );
        };

        subtest 'head to the left 2 spaces and up 1 space' => sub {
            my $head_position = RopeBridge::Position->new( x => 1, y => 0 );
            my $tail_position = RopeBridge::Position->new( x => 2, y => 1 );

            my $positions = [ $head_position, $tail_position, ];

            my $new_positions = RopeBridge::Move::execute( $positions, 'L' );

            is( $new_positions->[0],
                RopeBridge::Position->new( x => 0, y => 0 ) );
            is( $new_positions->[1],
                RopeBridge::Position->new( x => 1, y => 0 ) );
        };
    };
};

done_testing();
