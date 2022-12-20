#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use HillClimb::Map;
use HillClimb::Node;

my $puzzle_input = [
    [ 'S', 'a', 'b', 'q', 'p', 'o', 'n', 'm' ],
    [ 'a', 'b', 'c', 'r', 'y', 'x', 'x', 'l' ],
    [ 'a', 'c', 'c', 's', 'z', 'E', 'x', 'k' ],
    [ 'a', 'c', 'c', 't', 'u', 'v', 'w', 'j' ],
    [ 'a', 'b', 'd', 'e', 'f', 'g', 'h', 'i' ],
];

my @map;
for ( my $y = 0; $y < scalar( @{$puzzle_input} ); $y++ ) {
    my @row;
    for ( my $x = 0; $x < scalar( @{ $puzzle_input->[0] } ); $x++ ) {
        push(
            @row,
            HillClimb::Node->new(
                x      => $x,
                y      => $y,
                letter => $puzzle_input->[$y]->[$x]
            )
        );
    }
    push( @map, \@row );
}

subtest 'find_starting_node' => sub {
    subtest "should return the node that is marked 'S'" => sub {
        my $actual = HillClimb::Map::find_starting_node( \@map );

        my $expected = HillClimb::Node->new( x => 0, y => 0, letter => 'S' );

        is( $actual, $expected );
    };
};

subtest 'find_adjacent_nodes' => sub {
    subtest
        "should return a list of nodes that can be navigated to from the current node"
        => sub {
        subtest "nodes must be within lower bounds" => sub {
            my $current_node
                = HillClimb::Node->new( x => 0, y => 0, letter => 'a' );

            my $actual
                = HillClimb::Map::find_adjacent_nodes( \@map, $current_node );

            my $expected = [
                HillClimb::Node->new( x => 1, y => 0, letter => 'a' ),
                HillClimb::Node->new( x => 0, y => 1, letter => 'a' )
            ];

            is( $actual, $expected );
        };

        subtest "nodes must be within upper bounds" => sub {
            my $current_node
                = HillClimb::Node->new( x => 7, y => 4, letter => 'i' );

            my $actual
                = HillClimb::Map::find_adjacent_nodes( \@map, $current_node );

            my $expected = [
                HillClimb::Node->new( x => 7, y => 3, letter => 'j' ),
                HillClimb::Node->new( x => 6, y => 4, letter => 'h' )
            ];

            is( $actual, $expected );
        };

        subtest
            "nodes must be no more than 1 unit higher than current node" =>
            sub {
            my $current_node
                = HillClimb::Node->new( x => 2, y => 2, letter => 'c' );

            my $actual
                = HillClimb::Map::find_adjacent_nodes( \@map, $current_node );

            my $expected = [
                HillClimb::Node->new( x => 2, y => 1, letter => 'c' ),
                HillClimb::Node->new( x => 2, y => 3, letter => 'c' ),
                HillClimb::Node->new( x => 1, y => 2, letter => 'c' )
            ];

            is( $actual, $expected );
            };

        };
};

subtest 'find_exit_node' => sub {
    subtest "should return the node that is marked 'E'" => sub {
        my $actual = HillClimb::Map::find_exit_node( \@map );

        my $expected = HillClimb::Node->new( x => 5, y => 2, letter => 'E' );

        is( $actual, $expected );
    };
};

subtest 'find_adjacent_nodes_2' => sub {
    subtest
        "should return a list of nodes that can be navigated to from the current node"
        => sub {
        subtest "nodes must be within lower bounds" => sub {
            my $current_node
                = HillClimb::Node->new( x => 0, y => 0, letter => 'a' );

            my $actual
                = HillClimb::Map::find_adjacent_nodes_2( \@map,
                $current_node );

            my $expected = [
                HillClimb::Node->new( x => 1, y => 0, letter => 'a' ),
                HillClimb::Node->new( x => 0, y => 1, letter => 'a' )
            ];

            is( $actual, $expected );
        };

        subtest "nodes must be within upper bounds" => sub {
            my $current_node
                = HillClimb::Node->new( x => 7, y => 4, letter => 'i' );

            my $actual
                = HillClimb::Map::find_adjacent_nodes_2( \@map,
                $current_node );

            my $expected = [
                HillClimb::Node->new( x => 7, y => 3, letter => 'j' ),
                HillClimb::Node->new( x => 6, y => 4, letter => 'h' )
            ];

            is( $actual, $expected );
        };

        subtest
            "nodes must be no less than 1 unit lower than current node" =>
            sub {
            my $current_node
                = HillClimb::Node->new( x => 3, y => 2, letter => 's' );

            my $actual
                = HillClimb::Map::find_adjacent_nodes_2( \@map,
                $current_node );

            my $expected = [
                HillClimb::Node->new( x => 3, y => 1, letter => 'r' ),
                HillClimb::Node->new( x => 4, y => 2, letter => 'z' ),
                HillClimb::Node->new( x => 3, y => 3, letter => 't' )
            ];

            is( $actual, $expected );
            };

        };
};

done_testing();
