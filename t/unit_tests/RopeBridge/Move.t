#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';
use lib '/home/colin/AOC-2022/lib';

use RopeBridge::Move;
use RopeBridge::Position;

subtest 'execute' => sub {
    subtest 'should not move the tail if it is still touching the head' =>
        sub {
        my $head_position = RopeBridge::Position->new( x => 0, y => 0 );
        my $tail_position = RopeBridge::Position->new( x => 0, y => 0 );

        my ( $new_head_position, $new_tail_position )
            = RopeBridge::Move::execute( $head_position, $tail_position,
            'R' );

        is( $new_head_position, RopeBridge::Position->new( x => 1, y => 0 ) );
        is( $new_tail_position, $tail_position );
        };

    subtest 'should move the tail if it is not touching the head' => sub {
        subtest 'head to the right 2 spaces' => sub {
            my $head_position = RopeBridge::Position->new( x => 1, y => 0 );
            my $tail_position = RopeBridge::Position->new( x => 0, y => 0 );

            my ( $new_head_position, $new_tail_position )
                = RopeBridge::Move::execute( $head_position, $tail_position,
                'R' );

            is( $new_head_position,
                RopeBridge::Position->new( x => 2, y => 0 ) );
            is( $new_tail_position,
                RopeBridge::Position->new( x => 1, y => 0 ) );
        };

        subtest 'head to the right 1 space and down 2 spaces' => sub {
            my $head_position = RopeBridge::Position->new( x => 1, y => 1 );
            my $tail_position = RopeBridge::Position->new( x => 0, y => 0 );

            my ( $new_head_position, $new_tail_position )
                = RopeBridge::Move::execute( $head_position, $tail_position,
                'D' );

            is( $new_head_position,
                RopeBridge::Position->new( x => 1, y => 2 ) );
            is( $new_tail_position,
                RopeBridge::Position->new( x => 1, y => 1 ) );
        };

        subtest 'head to the right 2 spaces and down 1 space' => sub {
            my $head_position = RopeBridge::Position->new( x => 1, y => 1 );
            my $tail_position = RopeBridge::Position->new( x => 0, y => 0 );

            my ( $new_head_position, $new_tail_position )
                = RopeBridge::Move::execute( $head_position, $tail_position,
                'R' );

            is( $new_head_position,
                RopeBridge::Position->new( x => 2, y => 1 ) );
            is( $new_tail_position,
                RopeBridge::Position->new( x => 1, y => 1 ) );
        };
    };
};

done_testing();
