#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;

my $puzzle_input = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/03_puzzle_input.txt' );

# my $puzzle_input = [
#     'vJrwpWtwJgWrhcsFMMfFFhFp', 'jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL',
#     'PmmdzqPrVvPwwTWBwg',       'wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn',
#     'ttgJtRGJQctTZtZT',         'CrZsJsPPZsGzwwsLwLmpwMDw',
# ];

my %priority_values = (
    a   => 1,
    b   => 2,
    c   => 3,
    d   => 4,
    e   => 5,
    f   => 6,
    g   => 7,
    h   => 8,
    i   => 9,
    j   => 10,
    k   => 11,
    l   => 12,
    'm' => 13,
    n   => 14,
    o   => 15,
    p   => 16,
    q   => 17,
    r   => 18,
    's' => 19,
    t   => 20,
    u   => 21,
    v   => 22,
    w   => 23,
    x   => 24,
    y   => 25,
    z   => 26,
    A   => 27,
    B   => 28,
    C   => 29,
    D   => 30,
    E   => 31,
    F   => 32,
    G   => 33,
    H   => 34,
    I   => 35,
    J   => 36,
    K   => 37,
    L   => 38,
    M   => 39,
    N   => 40,
    O   => 41,
    P   => 42,
    Q   => 43,
    R   => 44,
    S   => 45,
    T   => 46,
    U   => 47,
    V   => 48,
    W   => 49,
    X   => 50,
    Y   => 51,
    Z   => 52,
);

my $priority_sum;
RUCKSACK:
foreach my $rucksack_content ( @{$puzzle_input} ) {
    my $number_of_items = length($rucksack_content);

    my $number_of_items_in_compartment = $number_of_items / 2;

    my @items = split( //, $rucksack_content );

    my @compartment_1_items =
      splice( @items, 0, $number_of_items_in_compartment );
    my @compartment_2_items = @items;

    foreach my $item (@compartment_1_items) {
        if ( grep( /^$item$/, @compartment_2_items ) ) {
            $priority_sum += $priority_values{$item};
            next RUCKSACK;
        }
    }
}

print 'Part 1 answer: ' . $priority_sum . "\n";

my $group_priority_sum;
RUCKSACK_GROUP:
for ( my $i = 0 ; $i < scalar @{$puzzle_input} ; $i += 3 ) {
    my @elf1 = split( //, $puzzle_input->[$i] );
    my @elf2 = split( //, $puzzle_input->[ $i + 1 ] );
    my @elf3 = split( //, $puzzle_input->[ $i + 2 ] );

    foreach my $item (@elf1) {
        if ( grep( /^$item$/, @elf2 ) && grep( /^$item$/, @elf3 ) ) {
            $group_priority_sum += $priority_values{$item};
            next RUCKSACK_GROUP;
        }
    }
}

print 'Part 2 answer: ' . $group_priority_sum . "\n";
