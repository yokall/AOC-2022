package RegolithResevoir::LineParser;

use strict;
use warnings;

use RegolithResevoir::Line;
use RegolithResevoir::Point;

sub parse_line_definition {
    my $line_definition = shift;

    my @coordinates = split( / -> /, $line_definition );

    my @corner_points;
    foreach my $coordinate (@coordinates) {
        my ( $x, $y ) = split( /,/, $coordinate );

        push( @corner_points,
            RegolithResevoir::Point->new( x => $x, y => $y ) );
    }

    my @points;
    push( @points, $corner_points[0] );
    for ( my $i = 1 ; $i < scalar(@corner_points) ; $i++ ) {
        my $previous_point = $corner_points[ $i - 1 ];
        my $current_point  = $corner_points[$i];

        if ( $previous_point->x == $current_point->x ) {
            if ( $current_point->y > $previous_point->y ) {
                for (
                    my $y = $previous_point->y + 1 ;
                    $y <= $current_point->y ;
                    $y++
                  )
                {
                    push(
                        @points,
                        RegolithResevoir::Point->new(
                            x => $current_point->x,
                            y => $y
                        )
                    );
                }
            }
            else {
                for (
                    my $y = $previous_point->y - 1 ;
                    $y >= $current_point->y ;
                    $y--
                  )
                {
                    push(
                        @points,
                        RegolithResevoir::Point->new(
                            x => $current_point->x,
                            y => $y
                        )
                    );
                }
            }
        }
        else {
            if ( $current_point->x > $previous_point->x ) {
                for (
                    my $x = $previous_point->x + 1 ;
                    $x <= $current_point->x ;
                    $x++
                  )
                {
                    push(
                        @points,
                        RegolithResevoir::Point->new(
                            x => $x,
                            y => $current_point->y
                        )
                    );
                }
            }
            else {
                for (
                    my $x = $previous_point->x - 1 ;
                    $x >= $current_point->x ;
                    $x--
                  )
                {
                    push(
                        @points,
                        RegolithResevoir::Point->new(
                            x => $x,
                            y => $current_point->y
                        )
                    );
                }
            }
        }
    }

    my $line = RegolithResevoir::Line->new( points => \@points );

    return $line;
}

1;
