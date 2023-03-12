package RegolithResevoir::Line;

use strict;
use warnings;

use List::Util qw(max min);
use Moose;

use RegolithResevoir::Point;

has 'points' => (
    traits  => ['Array'],
    is      => 'rw',
    isa     => 'ArrayRef[RegolithResevoir::Point]',
    handles => {
        all_points    => 'elements',
        add_point     => 'push',
        map_points    => 'map',
        filter_points => 'grep',
        find_point    => 'first',
        get_point     => 'get',
        join_points   => 'join',
        count_points  => 'count',
        has_points    => 'count',
        has_no_points => 'is_empty',
        sorted_points => 'sort',
    },
);

sub max_x {
    my $self = shift;

    my @xs = $self->map_points( sub { $_->x } );

    return max(@xs);
}

sub min_x {
    my $self = shift;

    my @xs = $self->map_points( sub { $_->x } );

    return min(@xs);
}

sub max_y {
    my $self = shift;

    my @ys = $self->map_points( sub { $_->y } );

    return max(@ys);
}

1;
