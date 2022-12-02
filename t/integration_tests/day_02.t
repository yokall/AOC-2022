#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

my $output_string = `perl bin/day_02.pl`;

is( $output_string,
    "Part 1 answer: 8933\nPart 2 answer: 11998\n",
    'Day 02 output is correct'
);

done_testing();
