use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'Text::YAMLFrontMatter',
    license           => 'perl',
    dist_author       => q{chunzi <chunzi@gmail.com>},
    dist_version_from => 'lib/Text/YAMLFrontMatter.pm',
    requires          => {
        'YAML::Syck'     => 0,
        'Text::Markdown' => 0,
    },
    build_requires     => { 'Test::More' => 0, },
    add_to_cleanup     => ['Text-YAMLFrontMatter-*'],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
