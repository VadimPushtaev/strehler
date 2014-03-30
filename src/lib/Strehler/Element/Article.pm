package Strehler::Element::Article;


use Moo;
use Dancer2 0.11;
use Dancer2::Plugin::DBIC;

extends 'Strehler::Element';

#Standard element implementation

sub metaclass_data 
{
    my $self = shift;
    my $param = shift;
    my %element_conf = ( item_type => 'article',
                         ORMObj => 'Article',
                         category_accessor => 'articles',
                         multilang_children => 'contents' );
    return $element_conf{$param};
}

#Main title redefined to fetch title from multilang attributes
sub main_title
{
    my $self = shift;
    my @contents = $self->row->contents->search({ language => config->{Strehler}->{default_language} });
    if($contents[0])
    {
        return $contents[0]->title;
    }
    else
    {
        #Should not be possible
        return "*** no title ***";
    }

}

#Ad hoc accessors and hooks
sub image
{
    my $self = shift;
    my $image = Strehler::Element::Image->new($self->row->image);
    if($image->exists())
    {
       return $image->get_attr('image');
    }
    else
    {
        return undef;
    }
}
sub save_slug
{
    my $self = shift;
    my $id = shift;
    my $form = shift;
    my $lan = shift;
    return $id . '-' . Strehler::Helpers::slugify($form->param_value('title_' . $lan));
}

#Method to manage slugs
sub get_by_slug
{
    my $self = shift;
    my $slug = shift;
    my $language = shift;
    my $chapter = $self->get_schema()->resultset('Content')->find({ slug => $slug, language => $language });
    if($chapter)
    {
        return $self->new($chapter->article->id);
    }
    else
    {
        return undef;
    }
}

=encoding utf8

=head1 NAME

Strehler::Element::Article - Strehler Entity for articles

=head1 DESCRIPTION

Base Strehler content, it's used to create general articles, multilanguage.

Its main title is the title in the language configured as default.

It also manages slugs, automatically generated using L<Strehler::Helpers> function slugify.
Articles can be retrived using slug through the get_by_slug function.

=head1 SYNOPSIS

    my $article = Strehler::Element::Article->get_by_slug('a-slug-suitable-for-web', $language)

=head1 FUNCTIONS

=over 4

=item get_by_slug

arguments: $slug, $language

retur value: $article

Retrive the Article $article using the slug generated in automatic by CMS. Language is given because a slug can exist under a language but not under another.

If no article with give slug is present, function return undef.

=back

=cut

1;







