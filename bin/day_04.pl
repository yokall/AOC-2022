#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use CampCleanup::Section;
use Common::FileReader;

my $puzzle_input = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/04_puzzle_input.txt' );

# my $puzzle_input =
#   [ '2-4,6-8', '2-3,4-5', '5-7,7-9', '2-8,3-7', '6-6,4-6', '2-6,4-8', ];

my $contains_count = 0;
my $overlaps_count = 0;
foreach my $line ( @{$puzzle_input} ) {
    my ( $section_definition_1, $section_definition_2 ) = split( /,/, $line );

    my ( $section_1_start, $section_1_end ) =
      split( /-/, $section_definition_1 );
    my ( $section_2_start, $section_2_end ) =
      split( /-/, $section_definition_2 );

    if (
        (
               $section_1_start >= $section_2_start
            && $section_1_end <= $section_2_end
        )
        || (   $section_2_start >= $section_1_start
            && $section_2_end <= $section_1_end )
      )
    {
        $contains_count++;
    }

    $overlaps_count++
      if (
        CampCleanup::Section::sections_overlap(
            $section_definition_1, $section_definition_2
        )
      );
}

print 'Part 1 answer: ' . $contains_count . "\n";

print 'Part 2 answer: ' . $overlaps_count . "\n";
