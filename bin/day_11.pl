#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use MonkeyBusiness::Monkey;

my @monkeys = (
    MonkeyBusiness::Monkey->new(
        items            => [ 75, 63 ],
        operator         => '*',
        operation_value  => '3',
        test_value       => 11,
        test_pass_monkey => 7,
        test_fail_monkey => 2,
    ),
    MonkeyBusiness::Monkey->new(
        items            => [ 65, 79, 98, 77, 56, 54, 83, 94 ],
        operator         => '+',
        operation_value  => '3',
        test_value       => 2,
        test_pass_monkey => 2,
        test_fail_monkey => 0,
    ),
    MonkeyBusiness::Monkey->new(
        items            => [66],
        operator         => '+',
        operation_value  => '5',
        test_value       => 5,
        test_pass_monkey => 7,
        test_fail_monkey => 5,
    ),
    MonkeyBusiness::Monkey->new(
        items            => [ 51, 89, 90 ],
        operator         => '*',
        operation_value  => '19',
        test_value       => 7,
        test_pass_monkey => 6,
        test_fail_monkey => 4,
    ),
    MonkeyBusiness::Monkey->new(
        items            => [ 75, 94, 66, 90, 77, 82, 61 ],
        operator         => '+',
        operation_value  => '1',
        test_value       => 17,
        test_pass_monkey => 6,
        test_fail_monkey => 1,
    ),
    MonkeyBusiness::Monkey->new(
        items            => [ 53, 76, 59, 92, 95 ],
        operator         => '+',
        operation_value  => '2',
        test_value       => 19,
        test_pass_monkey => 4,
        test_fail_monkey => 3,
    ),
    MonkeyBusiness::Monkey->new(
        items            => [ 81, 61, 75, 89, 70, 92 ],
        operator         => '*',
        operation_value  => 'old',
        test_value       => 3,
        test_pass_monkey => 0,
        test_fail_monkey => 1,
    ),
    MonkeyBusiness::Monkey->new(
        items            => [ 81, 86, 62, 87 ],
        operator         => '+',
        operation_value  => '8',
        test_value       => 13,
        test_pass_monkey => 3,
        test_fail_monkey => 5,
    )
);

# my @monkeys = (
#     MonkeyBusiness::Monkey->new(
#         items            => [ 79, 98 ],
#         operator         => '*',
#         operation_value  => '19',
#         test_value       => 23,
#         test_pass_monkey => 2,
#         test_fail_monkey => 3,
#     ),
#     MonkeyBusiness::Monkey->new(
#         items            => [ 54, 65, 75, 74 ],
#         operator         => '+',
#         operation_value  => '6',
#         test_value       => 19,
#         test_pass_monkey => 2,
#         test_fail_monkey => 0,
#     ),
#     MonkeyBusiness::Monkey->new(
#         items            => [ 79, 60, 97 ],
#         operator         => '*',
#         operation_value  => 'old',
#         test_value       => 13,
#         test_pass_monkey => 1,
#         test_fail_monkey => 3,
#     ),
#     MonkeyBusiness::Monkey->new(
#         items            => [74],
#         operator         => '+',
#         operation_value  => '3',
#         test_value       => 17,
#         test_pass_monkey => 0,
#         test_fail_monkey => 1,
#     )
# );

for ( my $r = 0; $r < 20; $r++ ) {
    foreach my $monkey (@monkeys) {
        my @items = @{ $monkey->items };

        for ( my $i = 0; $i < scalar(@items); $i++ ) {
            my $new_worry_level = $monkey->operation( $items[$i] );

            $new_worry_level = int( $new_worry_level / 3 );

            if ( $new_worry_level % $monkey->test_value == 0 ) {
                my @other_monkey_items
                    = @{ $monkeys[ $monkey->test_pass_monkey ]->items };

                @other_monkey_items
                    = ( @other_monkey_items, ($new_worry_level) );
                $monkeys[ $monkey->test_pass_monkey ]
                    ->items( \@other_monkey_items );

            }
            else {
                my @other_monkey_items
                    = @{ $monkeys[ $monkey->test_fail_monkey ]->items };

                @other_monkey_items
                    = ( @other_monkey_items, ($new_worry_level) );
                $monkeys[ $monkey->test_fail_monkey ]
                    ->items( \@other_monkey_items );
            }
        }

        # clear items list as all items have been thrown
        @items = ();
        $monkey->items( \@items );
    }
}

my @inspection_counts;
foreach my $monkey (@monkeys) {
    push( @inspection_counts, $monkey->inspection_count );
}

@inspection_counts = sort { $b <=> $a } @inspection_counts;

my $monkey_business_level = $inspection_counts[0] * $inspection_counts[1];

print 'Part 1 answer: ' . $monkey_business_level . "\n";
