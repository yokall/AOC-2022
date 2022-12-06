package SupplyStacks::InputParser;

use strict;
use warnings;

sub parse {
    my $input = shift;

    my $stacks = [];
    my @moves;

    foreach my $line ( @{$input} ) {
        if ( line_is_a_stack_definition($line) ) {
            $stacks = update_stacks_with_crates( $stacks, $line );
        }
        elsif ( _starts_with( $line, 'move' ) ) {
            push( @moves, $line );
        }
    }

    return $stacks, \@moves;
}

sub line_is_a_stack_definition {
    my $line = shift;

    return 1 if ( _starts_with( $line, "[" ) || _starts_with( $line, " " ) );

    return 0;
}

sub _starts_with {
    my $line  = shift;
    my $value = shift;

    return ( substr( $line, 0, length($value) ) eq $value );
}

sub update_stacks_with_crates {
    my $stacks = shift;
    my $line   = shift;

    my $stacks_count = ( length($line) + 1 ) / 4;

    for ( my $i = 0; $i < $stacks_count; $i++ ) {
        my $crate = substr( $line, ( $i * 4 ), 4 );

        if ( _starts_with( $crate, "[" ) ) {
            my $value = substr( $crate, 1, 1 );

            $stacks->[$i] = [] unless exists( $stacks->[$i] );

            my @stack = ( ($value), @{ $stacks->[$i] } );

            $stacks->[$i] = \@stack;
        }
    }

    return $stacks;
}

1;
