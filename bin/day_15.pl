#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;

use BeaconExclusionZone::Sensor;

my $puzzle_input = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/14_puzzle_input.txt' );

my $puzzle_input = [
    'Sensor at x=2, y=18: closest beacon is at x=-2, y=15',
    'Sensor at x=9, y=16: closest beacon is at x=10, y=16',
    'Sensor at x=13, y=2: closest beacon is at x=15, y=3',
    'Sensor at x=12, y=14: closest beacon is at x=10, y=16',
    'Sensor at x=10, y=20: closest beacon is at x=10, y=16',
    'Sensor at x=14, y=17: closest beacon is at x=10, y=16',
    'Sensor at x=8, y=7: closest beacon is at x=2, y=10',
    'Sensor at x=2, y=0: closest beacon is at x=2, y=10',
    'Sensor at x=0, y=11: closest beacon is at x=2, y=10',
    'Sensor at x=20, y=14: closest beacon is at x=25, y=17',
    'Sensor at x=17, y=20: closest beacon is at x=21, y=22',
    'Sensor at x=16, y=7: closest beacon is at x=15, y=3',
    'Sensor at x=14, y=3: closest beacon is at x=15, y=3',
    'Sensor at x=20, y=1: closest beacon is at x=15, y=3',
];
my $row_to_check = 10;

my @sensors;
foreach my $sensor_definition ( @{$puzzle_input} ) {
    my $sensor =
      BeaconExclusionZone::Sensor->new_from_input_text($sensor_definition);

    push( @sensors, $sensor );
}

my %excluded_positions;
foreach my $sensor (@sensors) {
    if ( $sensor->beacon_exclusion_zone->covers_row($row_to_check) ) {
        $excluded_positions{$_}++
          for (
            @{
                $sensor->beacon_exclusion_zone->excluded_positions_for_row(
                    $row_to_check)
            }
          );
    }
}

my $exclused_count = scalar( keys %excluded_positions );

print 'Part 1 answer: ' . $exclused_count . "\n";
