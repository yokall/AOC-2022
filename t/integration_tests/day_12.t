#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

my $output_string = `perl bin/day_12.pl`;

is( $output_string,
    "Part 1 answer: 361\nPart 2 answer: 354\n",
    'Day 12 output is correct'
);

done_testing();
