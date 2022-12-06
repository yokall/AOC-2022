package TuningTrouble::DataStream;

use strict;
use warnings;

sub find_start_of_packet_index {
    my $dataStream = shift;

    return _find_start_of_index( $dataStream, 4 );
}

sub find_start_of_message_index {
    my $dataStream = shift;

    return _find_start_of_index( $dataStream, 14 );
}

sub _find_start_of_index {
    my $dataStream   = shift;
    my $chunk_length = shift;

    my @chars = split( //, $dataStream );

CHUNK:
    for ( my $i = 0; $i < length($dataStream); $i++ ) {
        my @chunk;
        for ( my $c = 0; $c < $chunk_length; $c++ ) {
            push( @chunk, $chars[ $i + $c ] );
        }

        my %seen;
        foreach my $char (@chunk) {
            next CHUNK if $seen{$char}++;
        }

        return $i + $chunk_length;
    }

    return -1;
}

1;
