#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use RegolithResevoir::Line;
use RegolithResevoir::LineParser;
use RegolithResevoir::Point;

subtest 'parse_line_definition' => sub {
    subtest 'should return a line object from s string definition' => sub {
        my $line_definition = '498,4 -> 498,6 -> 496,6';

        my $actual =
          RegolithResevoir::LineParser::parse_line_definition($line_definition);

        my $points = [
            RegolithResevoir::Point->new( x => 498, y => 4 ),
            RegolithResevoir::Point->new( x => 498, y => 5 ),
            RegolithResevoir::Point->new( x => 498, y => 6 ),
            RegolithResevoir::Point->new( x => 497, y => 6 ),
            RegolithResevoir::Point->new( x => 496, y => 6 ),
        ];

        my $expected = RegolithResevoir::Line->new( points => $points );

        is( $actual, $expected );
    };
};

done_testing();
