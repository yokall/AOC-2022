#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use FindBin qw($Bin);
use lib "$Bin/lib";

use RegolithResevoir::Cave;
use RegolithResevoir::LineParser;

subtest 'new should populate the cave grid from the line defs' => sub {
    my @line_definitions =
      ( '498,4 -> 498,6 -> 496,6', '503,4 -> 502,4 -> 502,9 -> 494,9' );

    my @lines;
    foreach my $line_definition (@line_definitions) {
        my $line =
          RegolithResevoir::LineParser::parse_line_definition($line_definition);

        push( @lines, $line );
    }

    my $cave = RegolithResevoir::Cave->new( lines => \@lines );

    my $actual_grid   = $cave->grid;
    my $expected_grid = [
        [ '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', ],
        [ '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', ],
        [ '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', ],
        [ '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', ],
        [ '.', '.', '.', '.', '#', '.', '.', '.', '#', '#', ],
        [ '.', '.', '.', '.', '#', '.', '.', '.', '#', '.', ],
        [ '.', '.', '#', '#', '#', '.', '.', '.', '#', '.', ],
        [ '.', '.', '.', '.', '.', '.', '.', '.', '#', '.', ],
        [ '.', '.', '.', '.', '.', '.', '.', '.', '#', '.', ],
        [ '#', '#', '#', '#', '#', '#', '#', '#', '#', '.', ]
    ];

    is( $actual_grid, $expected_grid );
};

subtest
'draw should return a string that shows the position of everything in the cave'
  => sub {
    my $cave = _create_cave();

    my $expected_cave_string =
"..........\n..........\n..........\n..........\n....#...##\n....#...#.\n..###...#.\n........#.\n........#.\n#########.\n";

    is( $cave->draw(), $expected_cave_string );

    print $cave->draw();
  };

done_testing();

sub _create_cave {
    my @line_definitions =
      ( '498,4 -> 498,6 -> 496,6', '503,4 -> 502,4 -> 502,9 -> 494,9' );

    my @lines;
    foreach my $line_definition (@line_definitions) {
        my $line =
          RegolithResevoir::LineParser::parse_line_definition($line_definition);

        push( @lines, $line );
    }

    my $cave = RegolithResevoir::Cave->new( lines => \@lines );

    return $cave;
}
