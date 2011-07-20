package Text::YAMLFrontMatter::File;
use strict;
use warnings;

use File::Slurp::Unicode;
use Carp qw/ croak /;
use base 'Text::YAMLFrontMatter';
__PACKAGE__->mk_accessors(qw/ path /);

sub new {
    my $class = shift;
    my $path = shift;
    return unless defined $path;

    my $self = $class->SUPER::new;
    $self->path( $path );

    $self->read if -f $path;

    return $self;
}

sub read {
    my $self = shift;
    my $path = $self->path;
    my $text = -f $path ? read_file( $path ) : '';
    $self->SUPER::parse( $text );
}

sub save {
    my $self = shift;
    write_file( $self->path, $self->dump );
}



1;
