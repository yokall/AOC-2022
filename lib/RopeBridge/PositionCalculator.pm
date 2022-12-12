package RopeBridge::PositionCalculator;

use strict;
use warnings;

use RopeBridge::Position;

sub get_touching_positions {
    my ( $x, $y ) = @_;

    my @touching_positions;

    push( @touching_positions,
        RopeBridge::Position->new( x => $x, y => $y ) );

    push( @touching_positions,
        RopeBridge::Position->new( x => $x - 1, y => $y - 1 ) );

    push( @touching_positions,
        RopeBridge::Position->new( x => $x, y => $y - 1 ) );

    push( @touching_positions,
        RopeBridge::Position->new( x => $x + 1, y => $y - 1 ) );

    push( @touching_positions,
        RopeBridge::Position->new( x => $x - 1, y => $y ) );

    push( @touching_positions,
        RopeBridge::Position->new( x => $x + 1, y => $y ) );

    push( @touching_positions,
        RopeBridge::Position->new( x => $x - 1, y => $y + 1 ) );

    push( @touching_positions,
        RopeBridge::Position->new( x => $x, y => $y + 1 ) );

    push( @touching_positions,
        RopeBridge::Position->new( x => $x + 1, y => $y + 1 ) );

    return \@touching_positions;
}

1;
