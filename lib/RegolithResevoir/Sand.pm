package RegolithResevoir::Sand;

use strict;
use warnings;

use Moose;

use RegolithResevoir::Point;

has 'position' => (
    is      => 'rw',
    isa     => 'RegolithResevoir::Point',
    default => sub { RegolithResevoir::Point->new( x => 500, y => 0 ) }
);

has 'is_at_rest' => (
    traits  => ['Bool'],
    is      => 'rw',
    isa     => 'Bool',
    default => 0,
    handles => {
        set_at_rest    => 'set',
        is_not_at_rest => 'not',
    },
);

1;
