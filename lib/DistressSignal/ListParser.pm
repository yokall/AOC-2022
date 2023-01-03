package DistressSignal::ListParser;

use strict;
use warnings;

sub parse_string {
    my $string = shift;

    $string = substr( $string, 0, -1 );
    $string = substr( $string, 1 );

    warn "String: $string";

    my @elements;
    my $inside_a_list = 0;
    my $element;
    foreach my $c ( split //, $string ) {
        if ( $c eq ',' && $inside_a_list == 0 ) {
            push( @elements, $element );
            $element = '';
            next;
        }
        elsif ( $c eq '[' ) {
            $inside_a_list = 1;
        }
        elsif ( $c eq ']' ) {
            $inside_a_list = 0;
        }

        $element .= $c;
    }

    push( @elements, $element );

    # my @elements = split( ',', $string );

    use Data::Dumper;
    warn "ELEMENTS:";
    warn Dumper( \@elements );

    my @list;

    foreach my $element (@elements) {
        next unless $element;

        warn $element;

        if ( substr( $element, 0, 1 ) eq '[' ) {
            push( @list, parse_string($element) );
        }
        else {
            push( @list, int($element) );
        }
    }

    warn "LIST:";
    warn Dumper( \@list );

    return \@list;
}

1;
