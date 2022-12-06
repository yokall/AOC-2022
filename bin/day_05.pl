#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use SupplyStacks::Crane;
use SupplyStacks::InputParser;

my $puzzle_input = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/05_puzzle_input.txt' );

# my $puzzle_input = [
#     '    [D]    ',
#     '[N] [C]    ',
#     '[Z] [M] [P]',
#     ' 1   2   3 ',
#     '',
#     'move 1 from 2 to 1',
#     'move 3 from 1 to 3',
#     'move 2 from 2 to 1',
#     'move 1 from 1 to 2',
# ];

my $can_move_multiple_crates_at_once = 0;
my ( $stacks, $moves ) = SupplyStacks::InputParser::parse($puzzle_input);

foreach my $move ( @{$moves} ) {
    my $stacks = SupplyStacks::Crane::execute_move( $stacks, $move,
        $can_move_multiple_crates_at_once );
}

my $top_crates = _get_top_crates($stacks);

print 'Part 1 answer: ' . $top_crates . "\n";

$can_move_multiple_crates_at_once = 1;
( $stacks, $moves ) = SupplyStacks::InputParser::parse($puzzle_input);

foreach my $move ( @{$moves} ) {
    my $stacks = SupplyStacks::Crane::execute_move( $stacks, $move,
        $can_move_multiple_crates_at_once );
}

$top_crates = _get_top_crates($stacks);

print 'Part 2 answer: ' . $top_crates . "\n";

sub _get_top_crates {
    my $stacks = shift;

    my $top_crates;

    foreach my $stack ( @{$stacks} ) {
        if ( exists( $stack->[ scalar( @{$stack} ) - 1 ] ) ) {
            my $top_crate = $stack->[ scalar( @{$stack} ) - 1 ];
            $top_crates .= $top_crate;
        }
    }

    return $top_crates;
}
