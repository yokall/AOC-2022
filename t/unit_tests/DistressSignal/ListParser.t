#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use DistressSignal::ListParser;

subtest 'parse_string' => sub {

    subtest 'should return an array of numbers for simple integer list' =>
        sub {
        my $string = '[1,1,3,1,1]';

        my $actual = DistressSignal::ListParser::parse_string($string);

        my $expected = [ 1, 1, 3, 1, 1 ];

        is( $actual, $expected );
        };

    subtest 'should return an array containing array refs for sub lists' =>
        sub {
        my $string = '[[1],[2,3,4]]';

        my $actual = DistressSignal::ListParser::parse_string($string);

        my $expected = [ [1], [ 2, 3, 4 ] ];

        is( $actual, $expected );
        };

    subtest
        'should return an array containing array refs for sub lists - nested'
        => sub {
        my $string = '[1,[2,[3,[4,[5,6,7]]]],8,9]';

        my $actual = DistressSignal::ListParser::parse_string($string);

        my $expected = [ 1, [ 2, [ 3, [ 4, [ 5, 6, 7 ] ] ] ], 8, 9 ];

        is( $actual, $expected );
        };

    subtest 'should return an array containing empty array refs for []' =>
        sub {
        my $string = '[[[]]]';

        my $actual = DistressSignal::ListParser::parse_string($string);

        my $expected = [ [ [] ] ];

        is( $actual, $expected );
        };
};

done_testing();
