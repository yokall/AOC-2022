#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use TuningTrouble::DataStream;

my $puzzle_input = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/06_puzzle_input.txt' );

# my $puzzle_input = ['mjqjpqmgbljsphdztnvjfqwrcgsmlb'];

my $index;
foreach my $line ( @{$puzzle_input} ) {
    $index = TuningTrouble::DataStream::find_start_of_packet_index($line);
}

print 'Part 1 answer: ' . $index . "\n";

foreach my $line ( @{$puzzle_input} ) {
    $index = TuningTrouble::DataStream::find_start_of_message_index($line);
}

print 'Part 2 answer: ' . $index . "\n";
