#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use TreeHouse::Tree;

my $height_map = [
    [ '0', '0', '0', '0', '0' ],
    [ '0', '5', '5', '5', '0' ],
    [ '0', '5', '5', '5', '0' ],
    [ '0', '5', '5', '5', '0' ],
    [ '0', '0', '0', '0', '0' ],
];

subtest 'is_tree_visible' => sub {
    subtest 'should return true' => sub {
        subtest 'if no tree the same height or taller between it and the' =>
          sub {
            subtest 'top edge' => sub {
                my $x = 2;
                my $y = 1;
                my $visible =
                  TreeHouse::Tree::is_tree_visible( $height_map, $x, $y );

                is( $visible, 1 );
            };
            subtest 'right edge' => sub {
                my $x = 3;
                my $y = 2;
                my $visible =
                  TreeHouse::Tree::is_tree_visible( $height_map, $x, $y );

                is( $visible, 1 );
            };
            subtest 'bottom edge' => sub {
                my $x = 2;
                my $y = 3;
                my $visible =
                  TreeHouse::Tree::is_tree_visible( $height_map, $x, $y );

                is( $visible, 1 );
            };
            subtest 'left edge' => sub {
                my $x = 1;
                my $y = 2;
                my $visible =
                  TreeHouse::Tree::is_tree_visible( $height_map, $x, $y );

                is( $visible, 1 );
            };
          };
        subtest 'if the tree is on the' => sub {
            subtest 'top edge' => sub {
                my $x = 2;
                my $y = 0;
                my $visible =
                  TreeHouse::Tree::is_tree_visible( $height_map, $x, $y );

                is( $visible, 1 );
            };
            subtest 'right edge' => sub {
                my $x = 4;
                my $y = 3;
                my $visible =
                  TreeHouse::Tree::is_tree_visible( $height_map, $x, $y );

                is( $visible, 1 );
            };
            subtest 'bottom edge' => sub {
                my $x = 3;
                my $y = 4;
                my $visible =
                  TreeHouse::Tree::is_tree_visible( $height_map, $x, $y );

                is( $visible, 1 );
            };
            subtest 'left edge' => sub {
                my $x = 0;
                my $y = 3;
                my $visible =
                  TreeHouse::Tree::is_tree_visible( $height_map, $x, $y );

                is( $visible, 1 );
            };
        };
    };
};

subtest 'view_distance' => sub {
    my $height_map = [
        [ '3', '0', '3', '7', '3' ],
        [ '2', '5', '5', '1', '2' ],
        [ '6', '5', '3', '3', '2' ],
        [ '3', '3', '5', '4', '9' ],
        [ '3', '5', '3', '9', '0' ],
    ];
    my $x = 2;
    my $y = 1;

    subtest 'should be 1 when viewing up' => sub {
        my $view_distance =
          TreeHouse::Tree::view_distance( $height_map, $x, $y, 'up' );

        is( $view_distance, 1 );
    };

    subtest 'should be 2 when viewing right' => sub {
        my $view_distance =
          TreeHouse::Tree::view_distance( $height_map, $x, $y, 'right' );

        is( $view_distance, 2 );
    };

    subtest 'should be 2 when viewing down' => sub {
        my $view_distance =
          TreeHouse::Tree::view_distance( $height_map, $x, $y, 'down' );

        is( $view_distance, 2 );
    };

    subtest 'should be 1 when viewing left' => sub {
        my $view_distance =
          TreeHouse::Tree::view_distance( $height_map, $x, $y, 'left' );

        is( $view_distance, 1 );
    };
};

done_testing();
