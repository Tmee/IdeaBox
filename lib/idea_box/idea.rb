require 'yaml/store'

class Idea
  include Comparable
  attr_reader :title, :description, :rank, :id, :tag

  def initialize(attributes = {})
    @title       = attributes["title"]
    @description = attributes["description"]
    @rank        = attributes["rank"] || 0
    @id          = attributes["id"]
    @tag         = attributes["tag"]
  end

  def self.search

  end

  def save
    IdeaStore.create(to_h)
  end

  def to_h
  {
    "title" => title,
    "description" => description,
    "rank" => rank,
    "tag" => tag
  }
  end

  def like!
    @rank += 1
  end

  def <=>(other)
    other.rank <=> rank
  end

  def database
    Idea.database
  end
end