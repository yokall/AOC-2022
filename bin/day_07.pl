#!/usr/bin/perl

use strict;
use warnings;

use Data::Diver qw(DiveVal);
use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use NoSpace::InputParser;
use NoSpace::FileSystem;

my $puzzle_input = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/07_puzzle_input.txt' );

# my $puzzle_input = [
#     '$ cd /',
#     '$ ls',
#     'dir a',
#     '14848514 b.txt',
#     '8504156 c.dat',
#     'dir d',
#     '$ cd a',
#     '$ ls',
#     'dir e',
#     '29116 f',
#     '2557 g',
#     '62596 h.lst',
#     '$ cd e',
#     '$ ls',
#     '584 i',
#     '$ cd ..',
#     '$ cd ..',
#     '$ cd d',
#     '$ ls',
#     '4060174 j',
#     '8033020 d.log',
#     '5626152 d.ext',
#     '7214296 k',
# ];

my $file_system = NoSpace::InputParser::parse_input($puzzle_input);

$file_system = NoSpace::FileSystem::calculate_dir_sizes($file_system);

my $dir_size_sum = _sum_dirs_less_than_100k( $file_system, ['/'] );

sub _sum_dirs_less_than_100k {
    my ( $file_system, $current_dir ) = @_;

    my $sum = 0;

    my @directories;
    foreach my $directory ( @{$current_dir} ) {
        push( @directories, $directory );
        push( @directories, 'contents' );
    }

    my $current_contents = DiveVal( $file_system, @directories );

    foreach my $content_name ( keys %{$current_contents} ) {
        my $content = $current_contents->{$content_name};

        my @new_dir = ( @{$current_dir}, $content_name );

        $sum += _sum_dirs_less_than_100k( $file_system, \@new_dir )
            if ( $content->{type} eq 'dir' );
    }

    pop(@directories);
    my $current = DiveVal( $file_system, @directories );

    $sum += $current->{size}
        if ( $current->{type} eq 'dir' && $current->{size} < 100000 );

    return $sum;
}

print 'Part 1 answer: ' . $dir_size_sum . "\n";

my $required_space = 30000000 - ( 70000000 - $file_system->{'/'}->{size} );

my @dirs = @{
    _list_dirs_greater_than_required_space( $file_system, ['/'],
        $required_space )
};

sub _list_dirs_greater_than_required_space {
    my ( $file_system, $current_dir, $required_space ) = @_;

    my @dirs;

    my @directories;
    foreach my $directory ( @{$current_dir} ) {
        push( @directories, $directory );
        push( @directories, 'contents' );
    }

    my $current_contents = DiveVal( $file_system, @directories );

    foreach my $content_name ( keys %{$current_contents} ) {
        my $content = $current_contents->{$content_name};

        my @new_dir = ( @{$current_dir}, $content_name );

        push(
            @dirs,
            @{  _list_dirs_greater_than_required_space( $file_system,
                    \@new_dir, $required_space )
            }
        ) if ( $content->{type} eq 'dir' );
    }

    pop(@directories);
    my $current = DiveVal( $file_system, @directories );

    push( @dirs, $current->{size} )
        if ( $current->{type} eq 'dir'
        && $current->{size} > $required_space );

    return \@dirs;
}

my @sorted_dirs = sort { $a <=> $b } @dirs;

print 'Part 2 answer: ' . $sorted_dirs[0] . "\n";
