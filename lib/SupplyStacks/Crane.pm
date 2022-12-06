package SupplyStacks::Crane;

use strict;
use warnings;

sub execute_move {
    my $stacks                           = shift;
    my $move                             = shift;
    my $can_move_multiple_crates_at_once = shift;

    my $crate_count;
    my $from_stack;
    my $to_stack;
    if ( $move =~ m/move (\d+) from (\d+) to (\d+)/ ) {
        $crate_count = $1;
        $from_stack  = $2 - 1;
        $to_stack    = $3 - 1;
    }

    my @crates = splice( @{ $stacks->[$from_stack] }, -$crate_count );

    my @stack
        = $can_move_multiple_crates_at_once
        ? ( @{ $stacks->[$to_stack] }, @crates )
        : ( @{ $stacks->[$to_stack] }, reverse(@crates) );

    $stacks->[$to_stack] = \@stack;

    return $stacks;
}

1;
