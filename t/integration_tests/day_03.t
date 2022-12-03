#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

my $output_string = `perl bin/day_03.pl`;

is(
    $output_string,
    "Part 1 answer: 7597\nPart 2 answer: 2607\n",
    'Day 03 output is correct'
);

done_testing();
