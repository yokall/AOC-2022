#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use SupplyStacks::Crane;

subtest 'execute_move - CrateMover 9000' => sub {
    my $can_move_multiple_crates_at_once = 0;

    subtest 'should move 1 crate from stack 2 to stack 1' => sub {
        my $starting_stacks = [ [ 'Z', 'N' ], [ 'M', 'C', 'D' ], ['P'] ];
        my $move            = 'move 1 from 2 to 1';

        my $actual
            = SupplyStacks::Crane::execute_move( $starting_stacks, $move,
            $can_move_multiple_crates_at_once );

        my $expected_stacks = [ [ 'Z', 'N', 'D' ], [ 'M', 'C' ], ['P'] ];

        is( $actual, $expected_stacks );
    };

    subtest 'should move 3 crates from stack 1 to stack 3' => sub {
        my $starting_stacks = [ [ 'Z', 'N', 'D' ], [ 'M', 'C' ], ['P'] ];
        my $move            = 'move 3 from 1 to 3';

        my $actual
            = SupplyStacks::Crane::execute_move( $starting_stacks, $move,
            $can_move_multiple_crates_at_once );

        my $expected_stacks = [ [], [ 'M', 'C' ], [ 'P', 'D', 'N', 'Z' ] ];

        is( $actual, $expected_stacks );
    };
};

subtest 'execute_move - CrateMover 9001' => sub {
    my $can_move_multiple_crates_at_once = 1;

    subtest 'should move 1 crate from stack 2 to stack 1' => sub {
        my $starting_stacks = [ [ 'Z', 'N' ], [ 'M', 'C', 'D' ], ['P'] ];
        my $move            = 'move 1 from 2 to 1';

        my $actual
            = SupplyStacks::Crane::execute_move( $starting_stacks, $move,
            $can_move_multiple_crates_at_once );

        my $expected_stacks = [ [ 'Z', 'N', 'D' ], [ 'M', 'C' ], ['P'] ];

        is( $actual, $expected_stacks );
    };

    subtest 'should move 3 crates from stack 1 to stack 3' => sub {
        my $starting_stacks = [ [ 'Z', 'N', 'D' ], [ 'M', 'C' ], ['P'] ];
        my $move            = 'move 3 from 1 to 3';

        my $actual
            = SupplyStacks::Crane::execute_move( $starting_stacks, $move,
            $can_move_multiple_crates_at_once );

        my $expected_stacks = [ [], [ 'M', 'C' ], [ 'P', 'Z', 'N', 'D' ] ];

        is( $actual, $expected_stacks );
    };
};

done_testing();
