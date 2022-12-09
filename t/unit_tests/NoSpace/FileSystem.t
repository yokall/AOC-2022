#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use NoSpace::FileSystem;

subtest 'calculate_dir_sizes' => sub {
    subtest 'should calculate the size of directories recursively' => sub {
        my $file_system = {
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

        my $actual = NoSpace::FileSystem::calculate_dir_sizes($file_system);

        my $expected = {
            '/' => {
                type     => 'dir',
                size     => 48381165,
                contents => {
                    'a' => {
                        type     => 'dir',
                        size     => 94853,
                        contents => {
                            'e' => {
                                type     => 'dir',
                                size     => 584,
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
                        size     => 24933642,
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
