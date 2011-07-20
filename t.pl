#!/usr/bin/env perl
use lib './lib';
use Text::YAMLFrontMatter;

my $m = Text::YAMLFrontMatter->new;
$m->parse(q{


---
date: now
foo: bar
---




# title here

notes here

- list one
- list two

the end
});

use Data::Dumper;
print Dumper $m->meta;
print $m->markdown;
print $m->dump;

