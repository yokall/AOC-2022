#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

my $output_string = `perl bin/day_09.pl`;

is( $output_string, "Part 1 answer: 6269\n", 'Day 09 output is correct' );

done_testing();
