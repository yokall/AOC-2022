package RopeBridge::Move;

use strict;
use warnings;

use RopeBridge::PositionCalculator;

sub execute {
    my ( $positions, $direction ) = @_;

    $positions->[0] = _move_head( $positions->[0], $direction );
    $positions = _move_tail($positions);

    return $positions;
}

sub _move_head {
    my ( $head_position, $direction ) = @_;

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

    return $head_position;
}

sub _move_tail {
    my $positions = shift;

    for ( my $i = 0; $i < scalar( @{$positions} ) - 1; $i++ ) {
        my $head_position = $positions->[$i];
        my $tail_position = $positions->[ $i + 1 ];

        my $touching
            = RopeBridge::PositionCalculator::touching( $head_position,
            $tail_position );

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

        $positions->[$i] = $head_position;
        $positions->[ $i + 1 ] = $tail_position;
    }

    return $positions;
}

1;
