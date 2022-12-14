#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

my $output_string = `perl bin/day_11.pl`;

is( $output_string,
    "Part 1 answer: 62491\nPart 2 answer: 17408399184\n",
    'Day 11 output is correct'
);

done_testing();
