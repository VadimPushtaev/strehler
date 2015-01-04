use strict;
use warnings;

use lib "lib";
use lib "t/testapp/lib";

use Test::More;
use Plack::Builder;
use Plack::Test;
use HTTP::Request;
use HTTP::Request::Common;

$ENV{DANCER_CONFDIR} = 't/testapp';
$ENV{DANCER_ENVIRONMENT} = 'no_login';
require Strehler::Admin;
require t::testapp::lib::TestSupport;

TestSupport::reset_database();

my $app = Strehler::Admin->to_app;

test_psgi $app, sub {
    my $cb = shift;
    my $site = "http://localhost";
    my $r = $cb->(GET '/admin/article/add');
    like($r->content, qr/No category in the system/, "Article add blocked because no category");

    ok(Strehler::Element::Article->slugged(), "[configuration] Article has slug");

    #LIST
    $r = $cb->(GET '/admin/article/list');
    is($r->code, 200, "Articles page correctly accessed");
    $r = $cb->(GET '/admin/article/list?order-by=contents.title&order=asc');
    is($r->code, 200, "Articles page correctly accessed (order parameters added)");

    my $cat_id = TestSupport::create_category($cb, 'prova');

    $r = $cb->(POST "/admin/article/add",
                [ 'image' => undef,
                  'category' => $cat_id,
                  'subcategory' => undef,
                  'tags' => 'tag1',
                  'display_order' => 14,
                  'publish_date' => '12/03/2014',
                  'title_it' => 'Automatic test - title - IT',
                  'text_it' => 'Automatic test - body - IT',
                  'title_en' => 'Automatic test - title - EN',
                  'text_en' => 'Automatic test - body - EN',
                  'strehl-action' => 'submit-go' 
                ]);
   is($r->code, 302, "Article submitted, navigation redirected to list (submit-go)");
   my $articles = Strehler::Element::Article->get_list();
   my $article = $articles->{'to_view'}->[0];
   my $article_id = $article->{'id'};
   my $article_object = Strehler::Element::Article->new($article_id);
   ok($article_object->exists(), "Article correctly inserted");
   is($article_object->get_attr_multilang('slug', 'it'), $article_id . '-automatic-test-title-it', "Slug correctly created"); 
   $r = $cb->(POST "/admin/article/edit/$article_id",
                [ 'image' => undef,
                  'category' => $cat_id,
                  'subcategory' => undef,
                  'tags' => 'tag1',
                  'display_order' => 14,
                  'publish_date' => '12/03/2014',
                  'title_it' => 'Automatic test - title - IT',
                  'text_it' => 'Automatic test - body changed - IT',
                  'title_en' => 'Automatic test - title - EN',
                  'text_en' => 'Automatic test - body changed - EN',
                  'strehl-action' => 'submit-continue' 
                ]);
   is($r->code, 200, "Content changed, navigation still on edit page (submit-continue)");
   #TURN ON
   $r = $cb->(GET "/admin/article/turnon/$article_id");
   $article_object = Strehler::Element::Article->new($article_id);
   ok($article_object->get_attr('published'), "Article correctly published");

   #LAST CHAPTER
   my $req = HTTP::Request->new(GET => $site . "/admin/article/lastchapter/$cat_id");
   $req->header('X-Requested-With' => 'XMLHttpRequest');
   $r = $cb->($req); 
   is($r->content, 15, "Last chapter function works");

   #DELETE
   $r = $cb->(POST$site . "/admin/article/delete/$article_id");
   $article_object = Strehler::Element::Article->new($article_id);
   ok(! $article_object->exists(), "Article correctly deleted");
};
done_testing;
