package RopeBridge::Move;

use strict;
use warnings;

use Data::Compare;

use RopeBridge::Position;
use RopeBridge::PositionCalculator;

sub execute {
    my ( $head_position, $tail_position, $direction ) = @_;

    if ( $direction eq 'U' ) {
        $head_position->y( $head_position->y - 1 );
    }
    elsif ( $direction eq 'R' ) {
        $head_position->x( $head_position->x + 1 );
    }
    elsif ( $direction eq 'D' ) {
        $head_position->y( $head_position->y + 1 );
    }
    else {
        $head_position->x( $head_position->x - 1 );
    }

    my $touching_positions
        = RopeBridge::PositionCalculator::get_touching_positions(
        $head_position->x, $head_position->y );

    my $touching = 0;
    foreach my $position ( @{$touching_positions} ) {
        my $c = new Data::Compare( $tail_position, $position );
        if ( $c->Cmp ) {
            $touching = 1;
            last;
        }
    }

    unless ($touching) {
        if ( $tail_position->y == $head_position->y ) {
            my $x
                = $tail_position->x < $head_position->x
                ? $tail_position->x + 1
                : $tail_position->x - 1;
            $tail_position->x($x);
        }
        elsif ( $tail_position->x == $head_position->x ) {
            my $y
                = $tail_position->y < $head_position->y
                ? $tail_position->y + 1
                : $tail_position->y - 1;
            $tail_position->y($y);
        }
        elsif ( $tail_position->x < $head_position->x ) {
            $tail_position->x( $tail_position->x + 1 );

            if ( $tail_position->y > $head_position->y ) {
                $tail_position->y( $tail_position->y - 1 );
            }
            else {
                $tail_position->y( $tail_position->y + 1 );
            }
        }
        else {
            $tail_position->x( $tail_position->x - 1 );

            if ( $tail_position->y > $head_position->y ) {
                $tail_position->y( $tail_position->y - 1 );
            }
            else {
                $tail_position->y( $tail_position->y + 1 );
            }
        }
    }

    return ( $head_position, $tail_position );
}

1;
