#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Text::YAMLFrontMatter' ) || print "Bail out!
";
}

diag( "Testing Text::YAMLFrontMatter $Text::YAMLFrontMatter::VERSION, Perl $], $^X" );
