package RegolithResevoir::Cave;

use strict;
use warnings;

use Moose;

use RegolithResevoir::Line;
use RegolithResevoir::Sand;

has 'lines' => (
    traits  => ['Array'],
    is      => 'rw',
    isa     => 'ArrayRef[RegolithResevoir::Line]',
    trigger => \&_lines_set,
    handles => {
        all_lines    => 'elements',
        add_line     => 'push',
        map_lines    => 'map',
        filter_lines => 'grep',
        find_line    => 'first',
        get_line     => 'get',
        join_lines   => 'join',
        count_lines  => 'count',
        has_lines    => 'count',
        has_no_lines => 'is_empty',
        sorted_lines => 'sort',
    },
);

has 'grid' => (
    is  => 'rw',
    isa => 'ArrayRef[ArrayRef[Str]]',
);

has 'min_x' => (
    is  => 'rw',
    isa => 'Int',
);

has 'max_x' => (
    is  => 'rw',
    isa => 'Int',
);

has 'max_y' => (
    is  => 'rw',
    isa => 'Int',
);

has 'sand' => (
    traits  => ['Array'],
    is      => 'rw',
    isa     => 'ArrayRef[RegolithResevoir::Sand]',
    handles => {
        all_sand    => 'elements',
        add_sand    => 'push',
        map_sand    => 'map',
        filter_sand => 'grep',
        find_sand   => 'first',
        get_sand    => 'get',
        join_sand   => 'join',
        count_sand  => 'count',
        has_sand    => 'count',
        has_no_sand => 'is_empty',
        sorted_sand => 'sort',
    },
);

sub _lines_set {
    my ( $self, $lines, $old_lines ) = @_;

    _build_grid($self);
}

sub _build_grid {
    my $self = shift;

    $self->max_y( $self->_calculate_max_y() );
    $self->min_x( $self->_calculate_min_x() );
    $self->max_x( $self->_calculate_max_x() );

    my @grid;
    for ( my $y = 0 ; $y <= $self->max_y ; $y++ ) {
        my @row;
        for ( my $x = $self->min_x ; $x <= $self->max_x ; $x++ ) {
            $row[ $x - $self->min_x ] = '.';
        }
        push( @grid, \@row );
    }

    foreach my $line ( $self->all_lines() ) {
        foreach my $point ( $line->all_points() ) {
            $grid[ $point->y ]->[ $point->x - $self->min_x ] = '#';
        }
    }

    $self->grid( \@grid );
}

sub _calculate_max_x {
    my $self = shift;

    my $max_x = 0;
    foreach my $line ( $self->all_lines() ) {
        $max_x = $line->max_x() if $line->max_x() > $max_x;
    }

    return $max_x;
}

sub _calculate_min_x {
    my $self = shift;

    my $min_x = 99999;
    foreach my $line ( $self->all_lines() ) {
        $min_x = $line->min_x() if $line->min_x() < $min_x;
    }

    return $min_x;
}

sub _calculate_max_y {
    my $self = shift;

    my $max_y = 0;
    foreach my $line ( $self->all_lines() ) {
        $max_y = $line->max_y() if $line->max_y() > $max_y;
    }

    return $max_y;
}

sub draw {
    my $self = shift;

    my $depth = scalar( @{ $self->grid } );
    my $width = scalar( @{ $self->grid->[0] } );

    my $string;
    for ( my $y = 0 ; $y < $depth ; $y++ ) {
        for ( my $x = 0 ; $x < $width ; $x++ ) {
            $string .= $self->grid->[$y]->[$x];
        }
        $string .= "\n";
    }

    return $string;
}

sub add_new_piece_of_sand {
    my $self = shift;

    $self->add_sand( RegolithResevoir::Sand->new() );

    $self->grid->[0]->[ 500 - $self->min_x ] = 'o';
}

sub move_sand {
    my $self = shift;

    my $falling_sand = $self->find_sand( sub { $_->is_not_at_rest } );

    my $y_movement = 1;
    while (
        $self->_position_is_available(
            $falling_sand->position->x,
            $falling_sand->position->y + $y_movement
        )
      )
    {
        $y_movement++;
    }

    $self->grid->[ $falling_sand->position->y ]
      ->[ $falling_sand->position->x - $self->min_x ] = '.';

    $falling_sand->position->y(
        $falling_sand->position->y + ( $y_movement - 1 ) );

    $self->grid->[ $falling_sand->position->y ]
      ->[ $falling_sand->position->x - $self->min_x ] = 'o';

    return -1 if ( $falling_sand->position->y >= $self->max_y );

    if ( $self->grid->[ $falling_sand->position->y + 1 ]
        ->[ $falling_sand->position->x - $self->min_x - 1 ] ne '#'
        && $self->grid->[ $falling_sand->position->y + 1 ]
        ->[ $falling_sand->position->x - $self->min_x - 1 ] ne 'o' )
    {
        return -1 if ( $falling_sand->position->y + 1 == $self->max_y );

        $self->grid->[ $falling_sand->position->y + 1 ]
          ->[ $falling_sand->position->x - $self->min_x - 1 ] = 'o';

        $self->grid->[ $falling_sand->position->y ]
          ->[ $falling_sand->position->x - $self->min_x ] = '.';

        $falling_sand->position->x( $falling_sand->position->x - 1 );
        $falling_sand->position->y( $falling_sand->position->y + 1 );
    }
    elsif ( $self->grid->[ $falling_sand->position->y + 1 ]
        ->[ $falling_sand->position->x - $self->min_x + 1 ] ne '#'
        && $self->grid->[ $falling_sand->position->y + 1 ]
        ->[ $falling_sand->position->x - $self->min_x + 1 ] ne 'o' )
    {
        return -1 if ( $falling_sand->position->y + 1 == $self->max_y );

        $self->grid->[ $falling_sand->position->y + 1 ]
          ->[ $falling_sand->position->x - $self->min_x + 1 ] = 'o';

        $self->grid->[ $falling_sand->position->y ]
          ->[ $falling_sand->position->x - $self->min_x ] = '.';

        $falling_sand->position->x( $falling_sand->position->x + 1 );
        $falling_sand->position->y( $falling_sand->position->y + 1 );
    }
    else {
        $falling_sand->set_at_rest;

        $self->add_new_piece_of_sand();
    }

    return 1;
}

sub _position_is_available {
    my $self = shift;
    my ( $x, $y ) = @_;

    return 1
      if ( $y <= $self->max_y
        && $self->grid->[$y]->[ $x - $self->min_x ] ne '#'
        && $self->grid->[$y]->[ $x - $self->min_x ] ne 'o' );

    return 0;
}

1;
