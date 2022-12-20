package HillClimb::Map;

use strict;
use warnings;

use HillClimb::Node;

my %map_letter_to_height = (
    E   => 27,
    S   => 0,
    a   => 1,
    b   => 2,
    c   => 3,
    d   => 4,
    e   => 5,
    f   => 6,
    g   => 7,
    h   => 8,
    i   => 9,
    j   => 10,
    k   => 11,
    l   => 12,
    'm' => 13,
    n   => 14,
    o   => 15,
    p   => 16,
    q   => 17,
    r   => 18,
    's' => 19,
    t   => 20,
    u   => 21,
    v   => 22,
    w   => 23,
    x   => 24,
    y   => 25,
    z   => 26,
);

sub find_starting_node {
    my $map = shift;

    for ( my $y = 0; $y < scalar( @{$map} ); $y++ ) {
        for ( my $x = 0; $x < scalar( @{ $map->[0] } ); $x++ ) {
            if ( $map->[$y]->[$x]->letter eq 'S' ) {
                return $map->[$y]->[$x];
            }
        }
    }
}

sub find_adjacent_nodes {
    my $map          = shift;
    my $current_node = shift;

    my $current_node_height = $map_letter_to_height{ $current_node->letter };

    my @adjacent_nodes;

    if ( $current_node->y - 1 >= 0 ) {
        my $x = $current_node->x;
        my $y = $current_node->y - 1;

        my $node_height = $map_letter_to_height{ $map->[$y]->[$x]->letter };

        if ( $node_height <= $current_node_height + 1 ) {
            push( @adjacent_nodes, $map->[$y]->[$x] );
        }
    }

    if ( $current_node->x + 1 < scalar( @{ $map->[0] } ) ) {
        my $x = $current_node->x + 1;
        my $y = $current_node->y;

        my $node_height = $map_letter_to_height{ $map->[$y]->[$x]->letter };

        if ( $node_height <= $current_node_height + 1 ) {

            push( @adjacent_nodes, $map->[$y]->[$x] );
        }
    }

    if ( $current_node->y + 1 < scalar( @{$map} ) ) {
        my $x = $current_node->x;
        my $y = $current_node->y + 1;

        my $node_height = $map_letter_to_height{ $map->[$y]->[$x]->letter };

        if ( $node_height <= $current_node_height + 1 ) {

            push( @adjacent_nodes, $map->[$y]->[$x] );
        }
    }

    if ( $current_node->x - 1 >= 0 ) {
        my $x = $current_node->x - 1;
        my $y = $current_node->y;

        my $node_height = $map_letter_to_height{ $map->[$y]->[$x]->letter };

        if ( $node_height <= $current_node_height + 1 ) {

            push( @adjacent_nodes, $map->[$y]->[$x] );
        }
    }

    return \@adjacent_nodes;
}

sub find_exit_node {
    my $map = shift;

    for ( my $y = 0; $y < scalar( @{$map} ); $y++ ) {
        for ( my $x = 0; $x < scalar( @{ $map->[0] } ); $x++ ) {
            if ( $map->[$y]->[$x]->letter eq 'E' ) {
                return $map->[$y]->[$x];
            }
        }
    }
}

sub find_adjacent_nodes_2 {
    my $map          = shift;
    my $current_node = shift;

    my $current_node_height = $map_letter_to_height{ $current_node->letter };

    my @adjacent_nodes;

    if ( $current_node->y - 1 >= 0 ) {
        my $x = $current_node->x;
        my $y = $current_node->y - 1;

        my $node_height = $map_letter_to_height{ $map->[$y]->[$x]->letter };

        if ( $node_height >= $current_node_height - 1 ) {
            push( @adjacent_nodes, $map->[$y]->[$x] );
        }
    }

    if ( $current_node->x + 1 < scalar( @{ $map->[0] } ) ) {
        my $x = $current_node->x + 1;
        my $y = $current_node->y;

        my $node_height = $map_letter_to_height{ $map->[$y]->[$x]->letter };

        if ( $node_height >= $current_node_height - 1 ) {

            push( @adjacent_nodes, $map->[$y]->[$x] );
        }
    }

    if ( $current_node->y + 1 < scalar( @{$map} ) ) {
        my $x = $current_node->x;
        my $y = $current_node->y + 1;

        my $node_height = $map_letter_to_height{ $map->[$y]->[$x]->letter };

        if ( $node_height >= $current_node_height - 1 ) {

            push( @adjacent_nodes, $map->[$y]->[$x] );
        }
    }

    if ( $current_node->x - 1 >= 0 ) {
        my $x = $current_node->x - 1;
        my $y = $current_node->y;

        my $node_height = $map_letter_to_height{ $map->[$y]->[$x]->letter };

        if ( $node_height >= $current_node_height - 1 ) {

            push( @adjacent_nodes, $map->[$y]->[$x] );
        }
    }

    return \@adjacent_nodes;
}

1;
