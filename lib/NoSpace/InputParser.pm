package NoSpace::InputParser;

use strict;
use warnings;

use Data::Dumper;

use Data::Diver qw(DiveVal);
use Storable qw(dclone);

sub parse_input {
    my $input = shift;

    my %file_system;

    # my $parent_dir;
    my @current_dir;
    my %contents;
    my $reading_contents = 0;
    foreach my $line ( @{$input} ) {
        if ( $line =~ /\$ cd \// ) {
            @current_dir = ('/');

            $file_system{ $current_dir[-1] } = { type => 'dir' };
        }
        elsif ( $line =~ /\$ cd \.\./ ) {
            my @directories;
            foreach my $directory (@current_dir) {
                push( @directories, $directory );
                push( @directories, 'contents' );
            }

            my $temp_contents    = dclone( \%contents );
            my $current_contents = DiveVal( \%file_system, @directories );

            if ($current_contents) {
                my %merged_contents
                    = ( %{$current_contents}, %{$temp_contents} );

                DiveVal( \%file_system, @directories ) = \%merged_contents;
            }
            else {
                DiveVal( \%file_system, @directories ) = $temp_contents;
            }

            %contents = ();

            pop(@current_dir);
        }
        elsif ( $line =~ /\$ cd (\w+)/ ) {
            my $new_dirname = $1;

            # my @directories
            #     = grep {/\S/} ( '/', split( /\//, $current_dir ) );

            my @directories;
            foreach my $directory (@current_dir) {
                push( @directories, $directory );
                push( @directories, 'contents' );
            }

            # my @plain = grep { /\S/ } split(/\n/,$plaintext);

            # warn "DIRECTORIES";
            # warn Dumper( \@directories );

            my $temp_contents    = dclone( \%contents );
            my $current_contents = DiveVal( \%file_system, @directories );

            if ($current_contents) {
                my %merged_contents
                    = ( %{$current_contents}, %{$temp_contents} );

                DiveVal( \%file_system, @directories ) = \%merged_contents;
            }
            else {
                DiveVal( \%file_system, @directories ) = $temp_contents;
            }

            %contents = ();

            # $parent_dir = $current_dir;
            # $current_dir .= $new_dirname;

            push( @current_dir, $new_dirname );
        }
        elsif ( $line =~ /\$ ls/ ) {
            %contents         = ();
            $reading_contents = 1;
        }
        else {
            if ( $line =~ /dir (\w+)/ ) {
                my $dirname = $1;

                $contents{$dirname} = { type => 'dir', };
            }
            else {
                my ( $size, $filename ) = $line =~ /(\d+) ([\w,.]+)/;

                $contents{$filename} = { type => 'file', size => $size };
            }
        }

        # warn "LINE: '$line'";

        # warn "CURRENT DIR:";
        # warn Dumper( \@current_dir );

# # # warn "PARENT DIR: '$parent_dir'";
# # warn "CONTENTS:";
# # warn Dumper( \%contents );
# warn "FILESYSTEM:";
# warn Dumper( \%file_system );
# warn
#     "###########################################################################################################################################";

        # my $holding_input = <>;
    }

    my @directories;
    foreach my $directory (@current_dir) {
        push( @directories, $directory );
        push( @directories, 'contents' );
    }

    # my @plain = grep { /\S/ } split(/\n/,$plaintext);

    # warn "DIRECTORIES";
    # warn Dumper( \@directories );

    my $temp_contents = dclone( \%contents );

    DiveVal( \%file_system, (@directories) ) = $temp_contents;

    # warn "FILESYSTEM:";
    # warn Dumper( \%file_system );

    return \%file_system;
}

1;
