#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

my $output_string = `perl bin/day_08.pl`;

is(
    $output_string,
    "Part 1 answer: 1733\nPart 2 answer: 284648\n",
    'Day 08 output is correct'
);

done_testing();
