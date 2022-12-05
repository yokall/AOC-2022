#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use CampCleanup::Section;

subtest 'sections_overlap' => sub {
    subtest 'should return true if sections overlap' => sub {
        ok( CampCleanup::Section::sections_overlap( '5-7', '7-9' ) );
        ok( CampCleanup::Section::sections_overlap( '2-8', '3-7' ) );
        ok( CampCleanup::Section::sections_overlap( '6-6', '4-6' ) );
        ok( CampCleanup::Section::sections_overlap( '2-6', '4-8' ) );
    };

    subtest "should return false if sections don't overlap" => sub {
        ok( !CampCleanup::Section::sections_overlap( '2-4', '6-8' ) );
        ok( !CampCleanup::Section::sections_overlap( '2-3', '4-5' ) );
    };
};

done_testing();
