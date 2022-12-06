#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

my $output_string = `perl bin/day_05.pl`;

is( $output_string,
    "Part 1 answer: BWNCQRMDB\nPart 2 answer: NHWZCBNBF\n",
    'Day 05 output is correct'
);

done_testing();
