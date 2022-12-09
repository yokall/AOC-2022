package NoSpace::FileSystem;

use strict;
use warnings;

use Data::Diver qw(DiveVal);

sub calculate_dir_sizes {
    my $file_system = shift;

    $file_system->{'/'}->{size} = _calculate_dir_size( $file_system, ['/'] );

    return $file_system;
}

sub _calculate_dir_size {
    my ( $file_system, $current_dir ) = @_;

    my @directories;
    foreach my $directory ( @{$current_dir} ) {
        push( @directories, $directory );
        push( @directories, 'contents' );
    }

    my $current_contents = DiveVal( $file_system, @directories );

    my $size = 0;
    foreach my $content_name ( keys %{$current_contents} ) {
        my $content = $current_contents->{$content_name};
        if ( exists( $content->{size} ) ) {
            $size += $content->{size};
            next;
        }

        my @new_dir = @{$current_dir};
        push( @new_dir, $content_name );

        $content->{size} = _calculate_dir_size( $file_system, \@new_dir );

        $size += $content->{size};
    }

    return $size;
}

1;
