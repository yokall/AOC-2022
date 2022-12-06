#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib "/lib";

use TuningTrouble::DataStream;

subtest 'find_start_of_packet_index' => sub {
    subtest 'should return the starting index of the first 4 unique chars' =>
        sub {
        my $dataStream = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb';
        my $actual_index
            = TuningTrouble::DataStream::find_start_of_packet_index(
            $dataStream);

        my $expected_index = 7;

        is( $actual_index, $expected_index );

        $dataStream = 'bvwbjplbgvbhsrlpgdmjqwftvncz';
        $actual_index
            = TuningTrouble::DataStream::find_start_of_packet_index(
            $dataStream);

        $expected_index = 5;

        is( $actual_index, $expected_index );

        $dataStream = 'nppdvjthqldpwncqszvftbrmjlhg';
        $actual_index
            = TuningTrouble::DataStream::find_start_of_packet_index(
            $dataStream);

        $expected_index = 6;

        is( $actual_index, $expected_index );

        $dataStream = 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg';
        $actual_index
            = TuningTrouble::DataStream::find_start_of_packet_index(
            $dataStream);

        $expected_index = 10;

        is( $actual_index, $expected_index );

        $dataStream = 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw';
        $actual_index
            = TuningTrouble::DataStream::find_start_of_packet_index(
            $dataStream);

        $expected_index = 11;

        is( $actual_index, $expected_index );
        };
};

subtest 'find_start_of_message_index' => sub {
    subtest 'should return the starting index of the first 14 unique chars' =>
        sub {
        my $dataStream = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb';
        my $actual_index
            = TuningTrouble::DataStream::find_start_of_message_index(
            $dataStream);

        my $expected_index = 19;

        is( $actual_index, $expected_index );

        $dataStream = 'bvwbjplbgvbhsrlpgdmjqwftvncz';
        $actual_index
            = TuningTrouble::DataStream::find_start_of_message_index(
            $dataStream);

        $expected_index = 23;

        is( $actual_index, $expected_index );

        $dataStream = 'nppdvjthqldpwncqszvftbrmjlhg';
        $actual_index
            = TuningTrouble::DataStream::find_start_of_message_index(
            $dataStream);

        $expected_index = 23;

        is( $actual_index, $expected_index );

        $dataStream = 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg';
        $actual_index
            = TuningTrouble::DataStream::find_start_of_message_index(
            $dataStream);

        $expected_index = 29;

        is( $actual_index, $expected_index );

        $dataStream = 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw';
        $actual_index
            = TuningTrouble::DataStream::find_start_of_message_index(
            $dataStream);

        $expected_index = 26;

        is( $actual_index, $expected_index );
        };
};

done_testing();
