#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

my $output_string = `perl bin/day_01.pl`;

is( $output_string,
    "Part 1 answer: 250\nPart 2 answer: 200945\n",
    'Day 01 output is correct'
);

done_testing();
