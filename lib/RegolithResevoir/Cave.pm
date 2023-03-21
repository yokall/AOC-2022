package RegolithResevoir::Cave;

use strict;
use warnings;

use Moose;

use RegolithResevoir::Line;

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

sub _lines_set {
    my ( $self, $lines, $old_lines ) = @_;

    _build_grid($self);
}

sub _build_grid {
    my $self = shift;

    my $max_y = $self->_max_y();
    my $min_x = $self->_min_x();
    my $max_x = $self->_max_x();

    my @grid;
    for ( my $y = 0 ; $y <= $max_y ; $y++ ) {
        my @row;
        for ( my $x = $min_x ; $x <= $max_x ; $x++ ) {
            $row[ $x - $min_x ] = '.';
        }
        push( @grid, \@row );
    }

    foreach my $line ( $self->all_lines() ) {
        foreach my $point ( $line->all_points() ) {
            $grid[ $point->y ]->[ $point->x - $min_x ] = '#';
        }
    }

    $self->grid( \@grid );
}

sub _max_x {
    my $self = shift;

    my $max_x = 0;
    foreach my $line ( $self->all_lines() ) {
        $max_x = $line->max_x() if $line->max_x() > $max_x;
    }

    return $max_x;
}

sub _min_x {
    my $self = shift;

    my $min_x = 99999;
    foreach my $line ( $self->all_lines() ) {
        $min_x = $line->min_x() if $line->min_x() < $min_x;
    }

    return $min_x;
}

sub _max_y {
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

1;
