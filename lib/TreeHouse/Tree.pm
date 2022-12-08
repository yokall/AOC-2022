package TreeHouse::Tree;

use strict;
use warnings;

sub is_tree_visible {
    my ( $height_map, $x, $y ) = @_;

    my $tree_height = $height_map->[$y]->[$x];

    if (   _visible_from_top( $height_map, $x, $y, $tree_height )
        || _visible_from_right( $height_map, $x, $y, $tree_height )
        || _visible_from_bottom( $height_map, $x, $y, $tree_height )
        || _visible_from_left( $height_map, $x, $y, $tree_height ) )
    {
        return 1;
    }

    return 0;
}

sub _visible_from_top {
    my ( $height_map, $x, $start_y, $tree_height ) = @_;

    for ( my $y = $start_y - 1 ; $y >= 0 ; $y-- ) {
        return 0 if ( $height_map->[$y]->[$x] >= $tree_height );
    }

    return 1;
}

sub _visible_from_right {
    my ( $height_map, $start_x, $y, $tree_height ) = @_;

    for ( my $x = $start_x + 1 ; $x < scalar( @{ $height_map->[0] } ) ; $x++ ) {
        return 0 if ( $height_map->[$y]->[$x] >= $tree_height );
    }

    return 1;
}

sub _visible_from_bottom {
    my ( $height_map, $x, $start_y, $tree_height ) = @_;

    for ( my $y = $start_y + 1 ; $y < scalar( @{$height_map} ) ; $y++ ) {
        return 0 if ( $height_map->[$y]->[$x] >= $tree_height );
    }

    return 1;
}

sub _visible_from_left {
    my ( $height_map, $start_x, $y, $tree_height ) = @_;

    for ( my $x = $start_x - 1 ; $x >= 0 ; $x-- ) {
        return 0 if ( $height_map->[$y]->[$x] >= $tree_height );
    }

    return 1;
}

sub view_distance {
    my ( $height_map, $x, $y, $direction ) = @_;

    my $tree_height = $height_map->[$y]->[$x];

    if ( $direction eq 'up' ) {
        return _distance_visible_to_top( $height_map, $x, $y, $tree_height );
    }
    elsif ( $direction eq 'right' ) {
        return _distance_visible_to_right( $height_map, $x, $y, $tree_height );
    }
    elsif ( $direction eq 'down' ) {
        return _distance_visible_to_bottom( $height_map, $x, $y, $tree_height );
    }
    elsif ( $direction eq 'left' ) {
        return _distance_visible_to_left( $height_map, $x, $y, $tree_height );
    }

    return 0;
}

sub _distance_visible_to_top {
    my ( $height_map, $x, $start_y, $tree_height ) = @_;

    my $distance_visible = 0;
    for ( my $y = $start_y - 1 ; $y >= 0 ; $y-- ) {
        $distance_visible++;
        last if ( $height_map->[$y]->[$x] >= $tree_height );
    }

    return $distance_visible;
}

sub _distance_visible_to_right {
    my ( $height_map, $start_x, $y, $tree_height ) = @_;

    my $distance_visible = 0;
    for ( my $x = $start_x + 1 ; $x < scalar( @{ $height_map->[0] } ) ; $x++ ) {
        $distance_visible++;
        last if ( $height_map->[$y]->[$x] >= $tree_height );
    }

    return $distance_visible;
}

sub _distance_visible_to_bottom {
    my ( $height_map, $x, $start_y, $tree_height ) = @_;

    my $distance_visible = 0;
    for ( my $y = $start_y + 1 ; $y < scalar( @{$height_map} ) ; $y++ ) {
        $distance_visible++;
        last if ( $height_map->[$y]->[$x] >= $tree_height );
    }

    return $distance_visible;
}

sub _distance_visible_to_left {
    my ( $height_map, $start_x, $y, $tree_height ) = @_;

    my $distance_visible = 0;
    for ( my $x = $start_x - 1 ; $x >= 0 ; $x-- ) {
        $distance_visible++;
        last if ( $height_map->[$y]->[$x] >= $tree_height );
    }

    return $distance_visible;
}

1;
