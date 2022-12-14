package MonkeyBusiness::Monkey;

use strict;
use warnings;

use Moose;

has 'items' => (
    is  => 'rw',
    isa => 'ArrayRef[Int]',
);

has 'operator' => (
    is  => 'ro',
    isa => 'Str',
);

has 'operation_value' => (
    is  => 'ro',
    isa => 'Str',
);

has 'test_value' => (
    is  => 'ro',
    isa => 'Int',
);

has 'test_pass_monkey' => (
    is  => 'ro',
    isa => 'Int',
);

has 'test_fail_monkey' => (
    is  => 'ro',
    isa => 'Int',
);

has 'inspection_count' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0
);

sub operation {
    my $self        = shift;
    my $worry_level = shift;

    $self->inspection_count( $self->inspection_count + 1 );

    my $second_value
        = $self->operation_value() eq 'old'
        ? $worry_level
        : $self->operation_value();

    if ( $self->operator() eq '+' ) {
        return $worry_level + $second_value;
    }
    else {
        return $worry_level * $second_value;
    }
}

1;
