package CRT::Screen;

use strict;
use warnings;

sub render {
    my $register_cycle_values = shift;

    my @row1;
    for ( my $i = 0; $i <= 39; $i++ ) {
        my $register_value = $register_cycle_values->[ $i + 1 ];
        my $pixel_position = $i;

        if (   $pixel_position >= $register_value - 1
            && $pixel_position <= $register_value + 1 )
        {
            push( @row1, '#' );
        }
        else {
            push( @row1, '.' );
        }
    }

    my @row2;
    for ( my $i = 40; $i <= 79; $i++ ) {
        my $register_value = $register_cycle_values->[ $i + 1 ];
        my $pixel_position = $i - 40;

        if (   $pixel_position >= $register_value - 1
            && $pixel_position <= $register_value + 1 )
        {
            push( @row2, '#' );
        }
        else {
            push( @row2, '.' );
        }
    }

    my @row3;
    for ( my $i = 80; $i <= 119; $i++ ) {
        my $register_value = $register_cycle_values->[ $i + 1 ];
        my $pixel_position = $i - 80;

        if (   $pixel_position >= $register_value - 1
            && $pixel_position <= $register_value + 1 )
        {
            push( @row3, '#' );
        }
        else {
            push( @row3, '.' );
        }
    }

    my @row4;
    for ( my $i = 120; $i <= 159; $i++ ) {
        my $register_value = $register_cycle_values->[ $i + 1 ];
        my $pixel_position = $i - 120;

        if (   $pixel_position >= $register_value - 1
            && $pixel_position <= $register_value + 1 )
        {
            push( @row4, '#' );
        }
        else {
            push( @row4, '.' );
        }
    }

    my @row5;
    for ( my $i = 160; $i <= 199; $i++ ) {
        my $register_value = $register_cycle_values->[ $i + 1 ];
        my $pixel_position = $i - 160;

        if (   $pixel_position >= $register_value - 1
            && $pixel_position <= $register_value + 1 )
        {
            push( @row5, '#' );
        }
        else {
            push( @row5, '.' );
        }
    }

    my @row6;
    for ( my $i = 200; $i <= 239; $i++ ) {
        my $register_value = $register_cycle_values->[ $i + 1 ];
        my $pixel_position = $i - 200;

        if (   $pixel_position >= $register_value - 1
            && $pixel_position <= $register_value + 1 )
        {
            push( @row6, '#' );
        }
        else {
            push( @row6, '.' );
        }
    }

    return [ \@row1, \@row2, \@row3, \@row4, \@row5, \@row6 ];
}

1;
