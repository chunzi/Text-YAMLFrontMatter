#!/usr/bin/env perl
use lib './lib';
use Text::YAMLFrontMatter::File;

my $m = Text::YAMLFrontMatter::File->new(',test');
$m->meta({ updated => 0, pid => $$ });
$m->meta('chunzi' => 'bingo');
$m->meta('updated' => time );
printf "update: %s\n", $m->meta('updated');

$m->text(q{
# title

content

});
$m->save;

use Data::Dumper;
my $n = Text::YAMLFrontMatter::File->new(',test');
print $n->dump;

