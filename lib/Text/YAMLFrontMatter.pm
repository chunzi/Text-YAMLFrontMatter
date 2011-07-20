package Text::YAMLFrontMatter;

use warnings;
use strict;

our $VERSION = '0.01';

use Carp qw/ croak /;
use YAML::Syck qw//;
use Text::Markdown qw//;
use base qw/ Class::Accessor::Fast /;
__PACKAGE__->mk_accessors(qw/ text /);

sub new {
    my $class = shift;
    my $text = shift;

    my $self = bless { meta => {}, text => '' }, $class;
    $self->parse( $text ) if $text;

    return $self;
}


sub parse {
    my $self = shift;
    my $text = shift || $self->text;

    my $meta = {};
    $text =~ s/^(\s*\n)+//;
    if ( $text =~ /^---/ ){
        ( my $yaml, $text ) = split /\n---\n/, $text, 2;
        $text =~ s/^(\s*\n)+//;
        eval { 
            $meta = YAML::Syck::Load( $yaml );
        };
        croak "Load YAML Failed: $@" if $@;
    }

    $self->meta( $meta );
    $self->text( $text );

    return $self;
}

sub meta {
    my $self = shift;

    # no parameters, get entire meta hash
    if ( scalar @_ == 0 ){
        return $self->{'meta'};

    # single parameter
    }elsif( scalar @_ == 1 ){
        my $one = shift;

        # isa hash, assign as entire meta
        if ( ref $one eq 'HASH' ){
            $self->{'meta'} = $one;
            return $self->{'meta'};

        # isa a text, treat as meta key
        }elsif( ref $one eq '' ){
            return $self->{'meta'}{$one};
        }

    # two or more parameter
    }else{
        croak "not even parameters" unless scalar @_ % 2 == 0;
        my %set = @_;
        for ( keys %set ){
            $self->{'meta'}{$_} = $set{$_};
        }
        return $self->{'meta'};
    }
}

sub markdown { Text::Markdown->new->markdown( shift->text ) }

sub dump {
    my $self = shift;
    my $text = YAML::Syck::Dump( $self->meta );
    $text .= "---\n";
    $text .= $self->text;
    return $text;
}


1;

=head1 NAME

Text::YAMLFrontMatter - The great new Text::YAMLFrontMatter!

=head1 VERSION

Version 0.01

=cut

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Text::YAMLFrontMatter;

    my $foo = Text::YAMLFrontMatter->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=head2 function2


=head1 AUTHOR

chunzi, C<< <chunzi at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-text-yamlfrontmatter at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Text-YAMLFrontMatter>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Text::YAMLFrontMatter

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Text-YAMLFrontMatter>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Text-YAMLFrontMatter>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Text-YAMLFrontMatter>

=item * Search CPAN

L<http://search.cpan.org/dist/Text-YAMLFrontMatter/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 chunzi.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

