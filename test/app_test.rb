$:.unshift File.expand_path("./../../lib", __FILE__)
require 'bundler'
Bundler.require
require 'app'
require 'minitest/autorun'
require 'minitest/pride'
require 'nokogiri'

class IdeaBoxAppTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    IdeaStore.salt_the_earth
  end

  def app
    IdeaBoxApp
  end

  def test_index_lists_all_the_ideas_sorted_by_how_liked_they_are
    # put three ideas in the database, liked in a way that requires sorting
    IdeaStore.create 'title' => 'a', 'rank' => 3
    IdeaStore.create 'title' => 'b', 'rank' => 1
    IdeaStore.create 'title' => 'c', 'rank' => 2

    # go to the index
    get '/'

    # assert that I see the ideas in the expected order
    doc = Nokogiri::HTML(last_response.body)
    titles = doc.css('.ideas .title').map(&:text)
    assert_equal ['a', 'c', 'b'], titles
  end

  def test_index_has_a_form_to_create_new_ideas
    skip
  end

  def test_when_i_submit_the_form_it_creates_an_idea
    skip
  end
end
