#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use RegolithResevoir::Cave;
use RegolithResevoir::LineParser;

my $puzzle_input = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/14_puzzle_input.txt' );

# my $puzzle_input =
#   [ '498,4 -> 498,6 -> 496,6', '503,4 -> 502,4 -> 502,9 -> 494,9', ];

my @lines;
foreach my $line_definition ( @{$puzzle_input} ) {
    my $line =
      RegolithResevoir::LineParser::parse_line_definition($line_definition);

    push( @lines, $line );
}

my $cave = RegolithResevoir::Cave->new( lines => \@lines );

$cave->add_new_piece_of_sand();

my $count = 0;
while ( $cave->move_sand() != -1 ) {
    $count++;

    if ( $count % 100 == 0 ) {
        print "Count: $count:\n";
        print $cave->draw();
        print "\n";
    }

    if ( $count % 200 == 0 ) {
        last;
    }
}

my $ans = $cave->count_sand - 1;

print 'Part 1 answer: ' . $ans . "\n";

print 'Part 2 answer: ' . $ans . "\n";
