#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

my $output_string = `perl bin/day_06.pl`;

is( $output_string,
    "Part 1 answer: 1275\nPart 2 answer: 3605\n",
    'Day 06 output is correct'
);

done_testing();
