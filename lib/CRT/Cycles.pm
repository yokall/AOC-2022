package CRT::Cycles;

use strict;
use warnings;

sub model {
    my $instructions = shift;

    my @cycles;

    push( @cycles, 0 );

    foreach my $instruction ( @{$instructions} ) {
        if ( $instruction eq 'noop' ) {
            push( @cycles, 0 );
        }
        else {
            my ( $cmd, $amount ) = split( / /, $instruction );

            push( @cycles, 0 );
            push( @cycles, $amount );
        }
    }

    return \@cycles;
}

sub get_value_at_cycle {
    my ( $cycles, $cycle_number ) = @_;

    my $register = 1;
    for ( my $i = 0; $i < $cycle_number; $i++ ) {
        $register += $cycles->[$i];

        my $current_cycle = $i + 1;
    }

    return $register * $cycle_number;
}

sub get_values_for_all_cycles {
    my ($cycles) = @_;

    my @register_cycle_values;
    my $register = 1;
    push( @register_cycle_values, $register );
    foreach my $cycle ( @{$cycles} ) {
        $register += $cycle;

        push( @register_cycle_values, $register );
    }

    return \@register_cycle_values;
}

1;
