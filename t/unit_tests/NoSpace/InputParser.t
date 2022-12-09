#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use NoSpace::InputParser;

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

subtest 'parse_input' => sub {
    subtest 'should return a hash that models the file system' => sub {
        my $actual = NoSpace::InputParser::parse_input($puzzle_input);

        my $expected = {
            '/' => {
                type     => 'dir',
                contents => {
                    'a' => {
                        type     => 'dir',
                        contents => {
                            'e' => {
                                type     => 'dir',
                                contents => {
                                    'i' => {
                                        type => 'file',
                                        size => 584,
                                    },
                                },
                            },
                            'f' => {
                                type => 'file',
                                size => 29116,
                            },
                            'g' => {
                                type => 'file',
                                size => 2557,
                            },
                            'h.lst' => {
                                type => 'file',
                                size => 62596,
                            },
                        },
                    },
                    'b.txt' => {
                        type => 'file',
                        size => 14848514,
                    },
                    'c.dat' => {
                        type => 'file',
                        size => 8504156,
                    },
                    'd' => {
                        type     => 'dir',
                        contents => {
                            'j' => {
                                type => 'file',
                                size => 4060174,
                            },
                            'd.log' => {
                                type => 'file',
                                size => 8033020,
                            },
                            'd.ext' => {
                                type => 'file',
                                size => 5626152,
                            },
                            'k' => {
                                type => 'file',
                                size => 7214296,
                            },
                        },
                    },
                }
            }
        };

        is( $actual, $expected, 'description' );
    };
};

done_testing();
