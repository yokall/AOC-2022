package Common::FileReader;

use strict;
use warnings;

sub read_file_to_array {
    my $filename = shift;

    my $FH;
    open( $FH, '<', $filename ) or die $!;

    my @lines;
    while (<$FH>) {
        chomp;
        push( @lines, $_ );
    }

    close($FH);

    return \@lines;
}

sub read_file_to_2d_array {
    my $filename = shift;

    my $FH;
    open( $FH, '<', $filename ) or die $!;

    my @lines;
    while (<$FH>) {
        chomp;
        my $line       = $_;
        my @characters = split( //, $line );
        push( @lines, \@characters );
    }

    close($FH);

    return \@lines;
}

1;
