#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use RopeBridge::Move;

my $puzzle_input = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/09_puzzle_input.txt' );

# my $puzzle_input
#     = [ 'R 4', 'U 4', 'L 3', 'D 1', 'R 4', 'D 1', 'L 5', 'R 2', ];

my $head_position = RopeBridge::Position->new( x => 100, y => 100 );
my $tail_position = RopeBridge::Position->new( x => 100, y => 100 );

my %tail_positions;
foreach my $instruction ( @{$puzzle_input} ) {
    my ( $direction, $distance ) = split( / /, $instruction );

    for ( my $i = 0; $i < $distance; $i++ ) {

        ( $head_position, $tail_position )
            = RopeBridge::Move::execute( $head_position, $tail_position,
            $direction );

       # warn 'TAIL POSITION: ' . $tail_position->x . ',' . $tail_position->y;

        $tail_positions{ $tail_position->x . ',' . $tail_position->y } = 1;
    }
}

print 'Part 1 answer: ' . scalar( keys %tail_positions ) . "\n";

# print 'Part 2 answer: ' . $best_scenic_score . "\n";
