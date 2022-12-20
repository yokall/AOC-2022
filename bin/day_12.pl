#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use HillClimb::Map;
use HillClimb::Node;

my $puzzle_input = Common::FileReader::read_file_to_2d_array(
    dirname(__FILE__) . '/../files/12_puzzle_input.txt' );

# my $puzzle_input = [
#     [ 'S', 'a', 'b', 'q', 'p', 'o', 'n', 'm' ],
#     [ 'a', 'b', 'c', 'r', 'y', 'x', 'x', 'l' ],
#     [ 'a', 'c', 'c', 's', 'z', 'E', 'x', 'k' ],
#     [ 'a', 'c', 'c', 't', 'u', 'v', 'w', 'j' ],
#     [ 'a', 'b', 'd', 'e', 'f', 'g', 'h', 'i' ],
# ];

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

use Data::Dumper;

my $starting_node = HillClimb::Map::find_starting_node( \@map );
$starting_node->visit;

my @queue;

push( @queue, $starting_node );

my $number_of_steps_to_exit = 0;
while ( scalar( @queue > 0 ) ) {
    my $node = pop(@queue);

    # print "\nCURRENT NODE:\n";
    # print_node($node);

    if ( $node->letter eq 'E' ) {
        $number_of_steps_to_exit = $node->number_of_steps;
        last;
    }

    my $adjacent_nodes = HillClimb::Map::find_adjacent_nodes( \@map, $node );

    foreach my $adjacent_node ( @{$adjacent_nodes} ) {
        if ( $adjacent_node->has_not_been_visited ) {
            $adjacent_node->visit;
            $adjacent_node->number_of_steps( $node->number_of_steps + 1 );
            unshift( @queue, $adjacent_node );
        }
    }

    # print "\nQUEUE:\n";
    # print_queue( \@queue );
}

print 'Part 1 answer: ' . $number_of_steps_to_exit . "\n";

@map = ();
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

my $starting_node = HillClimb::Map::find_exit_node( \@map );
$starting_node->visit;

my @queue;

push( @queue, $starting_node );

my $number_of_steps_to_goal = 0;
while ( scalar( @queue > 0 ) ) {
    my $node = pop(@queue);

    # print "\nCURRENT NODE:\n";
    # print_node($node);

    if ( $node->letter eq 'a' ) {
        $number_of_steps_to_goal = $node->number_of_steps;
        last;
    }

    my $adjacent_nodes
        = HillClimb::Map::find_adjacent_nodes_2( \@map, $node );

    foreach my $adjacent_node ( @{$adjacent_nodes} ) {
        if ( $adjacent_node->has_not_been_visited ) {
            $adjacent_node->visit;
            $adjacent_node->number_of_steps( $node->number_of_steps + 1 );
            unshift( @queue, $adjacent_node );
        }
    }

    # print "\nQUEUE:\n";
    # print_queue( \@queue );
}

print 'Part 2 answer: ' . $number_of_steps_to_goal . "\n";

sub print_node {
    my $node = shift;

    print 'NODE: '
        . $node->letter . ', {'
        . $node->x . ', '
        . $node->y
        . '}, steps: '
        . $node->number_of_steps . "\n";
}

sub print_queue {
    my $queue = shift;

    foreach my $node ( @{$queue} ) {
        print_node($node);
    }
}
