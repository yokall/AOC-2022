#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use RegolithResevoir::Line;
use RegolithResevoir::Point;

subtest 'max_x should return the max X value from points' => sub {
    my $points = [
        RegolithResevoir::Point->new( x => 498, y => 4 ),
        RegolithResevoir::Point->new( x => 498, y => 6 ),
        RegolithResevoir::Point->new( x => 496, y => 6 ),
    ];

    my $line = RegolithResevoir::Line->new( points => $points );

    my $max_x = $line->max_x();

    is( $max_x, 498 );
};

subtest 'min_x should return the min X value from points' => sub {
    my $points = [
        RegolithResevoir::Point->new( x => 498, y => 4 ),
        RegolithResevoir::Point->new( x => 498, y => 6 ),
        RegolithResevoir::Point->new( x => 496, y => 6 ),
    ];

    my $line = RegolithResevoir::Line->new( points => $points );

    my $min_x = $line->min_x();

    is( $min_x, 496 );
};

subtest 'max_y should return the max Y value from points' => sub {
    my $points = [
        RegolithResevoir::Point->new( x => 498, y => 4 ),
        RegolithResevoir::Point->new( x => 498, y => 6 ),
        RegolithResevoir::Point->new( x => 496, y => 6 ),
    ];

    my $line = RegolithResevoir::Line->new( points => $points );

    my $max_y = $line->max_y();

    is( $max_y, 6 );
};

done_testing();
