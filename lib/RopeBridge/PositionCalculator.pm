package RopeBridge::PositionCalculator;

use strict;
use warnings;

use RopeBridge::Position;

sub touching {
    my $position1 = shift;
    my $position2 = shift;

    my $touching = 1;

    if (   abs( $position1->x - $position2->x ) > 1
        || abs( $position1->y - $position2->y ) > 1 )
    {
        $touching = 0;
    }

    return $touching;
}

1;
