#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use TreeHouse::Tree;

my $puzzle_input = Common::FileReader::read_file_to_2d_array(
    dirname(__FILE__) . '/../files/08_puzzle_input.txt' );

# my $puzzle_input = [
#     [ '3', '0', '3', '7', '3' ],
#     [ '2', '5', '5', '1', '2' ],
#     [ '6', '5', '3', '3', '2' ],
#     [ '3', '3', '5', '4', '9' ],
#     [ '3', '5', '3', '9', '0' ],
# ];

my $count = 0;
for ( my $y = 0 ; $y < scalar( @{$puzzle_input} ) ; $y++ ) {
    for ( my $x = 0 ; $x < scalar( @{ $puzzle_input->[0] } ) ; $x++ ) {
        $count++
          if ( TreeHouse::Tree::is_tree_visible( $puzzle_input, $x, $y ) );
    }
}

print 'Part 1 answer: ' . $count . "\n";

my $best_scenic_score = 0;
for ( my $y = 0 ; $y < scalar( @{$puzzle_input} ) ; $y++ ) {
    for ( my $x = 0 ; $x < scalar( @{ $puzzle_input->[0] } ) ; $x++ ) {
        my $scenic_score =
          TreeHouse::Tree::view_distance( $puzzle_input, $x, $y, 'up' ) *
          TreeHouse::Tree::view_distance( $puzzle_input, $x, $y, 'right' ) *
          TreeHouse::Tree::view_distance( $puzzle_input, $x, $y, 'down' ) *
          TreeHouse::Tree::view_distance( $puzzle_input, $x, $y, 'left' );

        $best_scenic_score = $scenic_score
          if ( $scenic_score > $best_scenic_score );
    }
}

print 'Part 2 answer: ' . $best_scenic_score . "\n";
