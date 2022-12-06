#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use SupplyStacks::InputParser;

subtest 'parse' => sub {
    my $puzzle_input = [
        '    [D]    ',
        '[N] [C]    ',
        '[Z] [M] [P]',
        ' 1   2   3 ',
        '',
        'move 1 from 2 to 1',
        'move 3 from 1 to 3',
        'move 2 from 2 to 1',
        'move 1 from 1 to 2',
    ];

    subtest 'should return the starting stacks' => sub {
        my ($actual) = SupplyStacks::InputParser::parse($puzzle_input);
        my $expected_stacks = [ [ 'Z', 'N' ], [ 'M', 'C', 'D' ], ['P'] ];

        is( $actual, $expected_stacks );
    };

    subtest 'should return the move instructions' => sub {
        my ( $stacks, $actual )
            = SupplyStacks::InputParser::parse($puzzle_input);
        my $expected_moves = [
            'move 1 from 2 to 1',
            'move 3 from 1 to 3',
            'move 2 from 2 to 1',
            'move 1 from 1 to 2',
        ];

        is( $actual, $expected_moves );
    };
};

subtest 'line_is_a_stack_definition' => sub {

    subtest 'should return true if the line starts with a space' => sub {
        my $line = '    [D]    ';
        my $actual
            = SupplyStacks::InputParser::line_is_a_stack_definition($line);

        my $expected = 1;

        is( $actual, $expected );
    };

    subtest "should return true if the line starts with a '['" => sub {
        my $line = '[N] [C]    ';
        my $actual
            = SupplyStacks::InputParser::line_is_a_stack_definition($line);

        my $expected = 1;

        is( $actual, $expected );
    };

    subtest 'should return false otherwise' => sub {
        my $line = '';
        my $actual
            = SupplyStacks::InputParser::line_is_a_stack_definition($line);

        my $expected = 0;

        is( $actual, $expected );
    };
};

subtest 'update_stacks_with_crates' => sub {

    subtest 'should start a new stack at the correct index' => sub {
        my $stacks = [ [], [], [] ];
        my $line   = '    [D]    ';

        $stacks
            = SupplyStacks::InputParser::update_stacks_with_crates( $stacks,
            $line );

        my $expected_stacks = [ [], ['D'], [] ];

        is( $stacks, $expected_stacks );
    };

    subtest 'should add new crates at the start of a stack' => sub {
        my $stacks = [ [], ['D'], [] ];
        my $line   = '    [E]    ';

        $stacks
            = SupplyStacks::InputParser::update_stacks_with_crates( $stacks,
            $line );

        my $expected_stacks = [ [], [ 'E', 'D' ], [] ];

        is( $stacks, $expected_stacks );
    };
};

done_testing();
