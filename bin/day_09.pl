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

my $positions = [
    RopeBridge::Position->new( x => 100, y => 100 ),
    RopeBridge::Position->new( x => 100, y => 100 ),
];

my $part1_ans = _execute_moves( $positions, $puzzle_input );

print 'Part 1 answer: ' . $part1_ans . "\n";

$positions = [
    RopeBridge::Position->new( x => 100, y => 100 ),
    RopeBridge::Position->new( x => 100, y => 100 ),
    RopeBridge::Position->new( x => 100, y => 100 ),
    RopeBridge::Position->new( x => 100, y => 100 ),
    RopeBridge::Position->new( x => 100, y => 100 ),
    RopeBridge::Position->new( x => 100, y => 100 ),
    RopeBridge::Position->new( x => 100, y => 100 ),
    RopeBridge::Position->new( x => 100, y => 100 ),
    RopeBridge::Position->new( x => 100, y => 100 ),
    RopeBridge::Position->new( x => 100, y => 100 ),
];

my $part2_ans = _execute_moves( $positions, $puzzle_input );

print 'Part 2 answer: ' . $part2_ans . "\n";

sub _execute_moves {
    my ( $positions, $move_instructions ) = @_;

    my %tail_positions;
    foreach my $instruction ( @{$move_instructions} ) {
        my ( $direction, $distance ) = split( / /, $instruction );

        for ( my $i = 0; $i < $distance; $i++ ) {

            ($positions)
                = RopeBridge::Move::execute( $positions, $direction );

            $tail_positions{ $positions->[-1]->x . ',' . $positions->[-1]->y }
                = 1;
        }
    }

    return scalar( keys %tail_positions );
}
