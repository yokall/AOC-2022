#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

# skip this test file as Cave class broke down once there was no nin X
use Test2::Require::AuthorTesting;

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
  };

subtest
  'add_new_piece_of_sand should add a new piece of sand at position (0,500)' =>
  sub {
    my $cave = _create_cave();

    $cave->add_new_piece_of_sand();

    my $expected_cave_string =
"......o...\n..........\n..........\n..........\n....#...##\n....#...#.\n..###...#.\n........#.\n........#.\n#########.\n";

    is( $cave->draw(), $expected_cave_string );
  };

subtest 'move_sand' => sub {
    subtest 'should move the falling piece of sand' => sub {
        subtest 'straight down when there is nothing beneath it' => sub {
            my $cave = _create_cave();

            $cave->add_new_piece_of_sand();
            $cave->move_sand();

            my $expected_cave_string =
"......o...\n..........\n..........\n..........\n....#...##\n....#...#.\n..###...#.\n........#.\n......o.#.\n#########.\n";

            is( $cave->draw(), $expected_cave_string );
        };

        subtest
'down and to the left when there is something beneath it but space down and to the left'
          => sub {
            my $cave = _create_cave();

            $cave->add_new_piece_of_sand();
            $cave->move_sand();
            $cave->move_sand();

            my $expected_cave_string =
"......o...\n..........\n..........\n..........\n....#...##\n....#...#.\n..###...#.\n........#.\n.....oo.#.\n#########.\n";

            is( $cave->draw(), $expected_cave_string );
          };

        subtest
'down and to the right when there is something beneath it, down and to the left but space down and to the right'
          => sub {
            my $cave = _create_cave();

            $cave->add_new_piece_of_sand();
            $cave->move_sand() for 1 .. 3;

            my $expected_cave_string =
"......o...\n..........\n..........\n..........\n....#...##\n....#...#.\n..###...#.\n........#.\n.....ooo#.\n#########.\n";

            is( $cave->draw(), $expected_cave_string );
          };
    };

    subtest
'should add a new piece of sand when the falling piece of sand has come to rest'
      => sub {
        my $cave = _create_cave();

        $cave->add_new_piece_of_sand();
        $cave->move_sand();

        my $expected_cave_string =
"......o...\n..........\n..........\n..........\n....#...##\n....#...#.\n..###...#.\n........#.\n......o.#.\n#########.\n";

        is( $cave->draw(), $expected_cave_string );
      };
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
