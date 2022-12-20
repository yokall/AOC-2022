#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use HillClimb::Map;
use HillClimb::Node;

my $map = [
    [ 'S', 'a', 'b', 'q', 'p', 'o', 'n', 'm' ],
    [ 'a', 'b', 'c', 'r', 'y', 'x', 'x', 'l' ],
    [ 'a', 'c', 'c', 's', 'z', 'E', 'x', 'k' ],
    [ 'a', 'c', 'c', 't', 'u', 'v', 'w', 'j' ],
    [ 'a', 'b', 'd', 'e', 'f', 'g', 'h', 'i' ],
];

subtest 'find_starting_node' => sub {
    subtest "should return the node that is marked 'S'" => sub {
        my $actual = HillClimb::Map::find_starting_node($map);

        my $expected = HillClimb::Node->new( x => 0, y => 0, letter => 'S' );

        is( $actual, $expected );
    };
};

subtest 'find_adjacent_nodes' => sub {
    subtest
        "should return a list of nodes that can be navigated to from the current node"
        => sub {
        subtest "nodes must be within lower bounds" => sub {
            my $current_node = HillClimb::Node->new( x => 0, y => 0 );

            my $actual
                = HillClimb::Map::find_adjacent_nodes( $map, $current_node );

            my $expected = [
                HillClimb::Node->new( x => 1, y => 0, letter => 'a' ),
                HillClimb::Node->new( x => 0, y => 1, letter => 'a' )
            ];

            is( $actual, $expected );
        };

        subtest "nodes must be within upper bounds" => sub {
            my $current_node = HillClimb::Node->new( x => 7, y => 4 );

            my $actual
                = HillClimb::Map::find_adjacent_nodes( $map, $current_node );

            my $expected = [
                HillClimb::Node->new( x => 7, y => 3, letter => 'j' ),
                HillClimb::Node->new( x => 6, y => 4, letter => 'h' )
            ];

            is( $actual, $expected );
        };

        subtest
            "nodes must be no more than 1 unit higher than current node" =>
            sub {
            my $current_node = HillClimb::Node->new( x => 2, y => 2 );

            my $actual
                = HillClimb::Map::find_adjacent_nodes( $map, $current_node );

            my $expected = [
                HillClimb::Node->new( x => 2, y => 1, letter => 'c' ),
                HillClimb::Node->new( x => 2, y => 3, letter => 'c' ),
                HillClimb::Node->new( x => 1, y => 2, letter => 'c' )
            ];

            is( $actual, $expected );
            };

        };
};

done_testing();
