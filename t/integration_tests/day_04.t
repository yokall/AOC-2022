#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

my $output_string = `perl bin/day_04.pl`;

is(
    $output_string,
    "Part 1 answer: 571\nPart 2 answer: 917\n",
    'Day 04 output is correct'
);

done_testing();
