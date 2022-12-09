#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

my $output_string = `perl bin/day_07.pl`;

is( $output_string,
    "Part 1 answer: 1908462\nPart 2 answer: 3979145\n",
    'Day 07 output is correct'
);

done_testing();
