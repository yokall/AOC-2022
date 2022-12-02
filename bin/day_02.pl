#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;
use List::Util qw/sum max/;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;

my $puzzle_input = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/02_puzzle_input.txt' );

# my $puzzle_input = [ 'A Y', 'B X', 'C Z', ];

# A for Rock, B for Paper, and C for Scissors
# X for Rock, Y for Paper, and Z for Scissors

my %result_points = (
    A => {
        X => 3,
        Y => 6,
        Z => 0,
    },
    B => {
        X => 0,
        Y => 3,
        Z => 6,
    },
    C => {
        X => 6,
        Y => 0,
        Z => 3,
    },
);

my %choice_points = (
    X => 1,
    Y => 2,
    Z => 3,
);

my @round_points;
foreach my $round ( @{$puzzle_input} ) {
    my ( $opponent_choice, $my_choice ) = split( / /, $round );

    my $result = $result_points{$opponent_choice}->{$my_choice};
    my $choice = $choice_points{$my_choice};

    push( @round_points, ( $result + $choice ) );
}

print 'Part 1 answer: ' . sum(@round_points) . "\n";

my %responses = (
    A => {
        X => 'Z',
        Y => 'X',
        Z => 'Y',
    },
    B => {
        X => 'X',
        Y => 'Y',
        Z => 'Z',
    },
    C => {
        X => 'Y',
        Y => 'Z',
        Z => 'X',
    },
);

@round_points = ();
foreach my $round ( @{$puzzle_input} ) {
    my ( $opponent_choice, $desired_result ) = split( / /, $round );

    my $my_choice = $responses{$opponent_choice}->{$desired_result};

    my $result = $result_points{$opponent_choice}->{$my_choice};
    my $choice = $choice_points{$my_choice};

    push( @round_points, ( $result + $choice ) );
}

print 'Part 2 answer: ' . sum(@round_points) . "\n";
