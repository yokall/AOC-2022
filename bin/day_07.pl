#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use TuningTrouble::DataStream;

my $puzzle_input = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/07_puzzle_input.txt' );

my $puzzle_input = [
    '$ cd /',
    '$ ls',
    'dir a',
    '14848514 b.txt',
    '8504156 c.dat',
    'dir d',
    '$ cd a',
    '$ ls',
    'dir e',
    '29116 f',
    '2557 g',
    '62596 h.lst',
    '$ cd e',
    '$ ls',
    '584 i',
    '$ cd ..',
    '$ cd ..',
    '$ cd d',
    '$ ls',
    '4060174 j',
    '8033020 d.log',
    '5626152 d.ext',
    '7214296 k',
];

my $index;
foreach my $line ( @{$puzzle_input} ) {
    $index = TuningTrouble::DataStream::find_start_of_packet_index($line);
}

# print 'Part 1 answer: ' . $index . "\n";

# print 'Part 2 answer: ' . $index . "\n";
