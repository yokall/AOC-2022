package HillClimb::Node;

use strict;
use warnings;

use Moose;

has 'letter' => (
    is  => 'ro',
    isa => 'Str',
);

has 'x' => (
    is  => 'ro',
    isa => 'Int',
);

has 'y' => (
    is  => 'ro',
    isa => 'Int',
);

has 'is_visited' => (
    traits  => ['Bool'],
    is      => 'rw',
    isa     => 'Bool',
    default => 0,
    handles => {
        visit                => 'set',
        has_not_been_visited => 'not',
    },
);

has 'number_of_steps' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

1;
