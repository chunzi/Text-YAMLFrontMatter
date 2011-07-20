#!/usr/bin/env perl
use lib './lib';
use Text::YAMLFrontMatter::File;

my $m = Text::YAMLFrontMatter::File->new(',test');
$m->meta({ now => time, pid => $$ });
$m->text(q{
# title

content

});
print $m->save;

use Data::Dumper;
print Dumper $m->meta;
print $m->markdown;
print $m->dump;

