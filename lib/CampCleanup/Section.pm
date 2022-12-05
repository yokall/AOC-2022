package CampCleanup::Section;

use strict;
use warnings;

sub sections_overlap {
    my $section_definition_1 = shift;
    my $section_definition_2 = shift;

    my ( $section_1_start, $section_1_end ) =
      split( /-/, $section_definition_1 );
    my ( $section_2_start, $section_2_end ) =
      split( /-/, $section_definition_2 );

    return (
        (
                 $section_1_start <= $section_2_end
              && $section_1_end >= $section_2_start
        )
          || ( $section_2_start <= $section_1_end
            && $section_2_end >= $section_1_start )
    );
}

1;
