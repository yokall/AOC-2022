#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;
use List::Util qw/sum max/;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;

my $puzzle_input = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/01_puzzle_input.txt' );

# my $puzzle_input = [
#     '1000', '2000', '3000', '',     '4000', '', '5000', '6000',
#     '',     '7000', '8000', '9000', '',     '10000',
# ];

my @elf_calorie_totals;
my @current_elf;
foreach my $line ( @{$puzzle_input} ) {
    if ( $line eq '' ) {
        my @elf_total = @current_elf;
        push( @elf_calorie_totals, sum @current_elf );
        @current_elf = ();
        next;
    }

    push( @current_elf, $line );
}

push( @elf_calorie_totals, sum @current_elf );

print 'Part 1 answer: ' . max @elf_calorie_totals . "\n";

my @sorted_elf_calorie_totals = sort { $b <=> $a } @elf_calorie_totals;

print 'Part 2 answer: '
    . (   $sorted_elf_calorie_totals[0]
        + $sorted_elf_calorie_totals[1]
        + $sorted_elf_calorie_totals[2] )
    . "\n";
