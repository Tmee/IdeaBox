require 'yaml/store'

class IdeaStore

  def self.all
    ideas = []
    raw_ideas.each_with_index do |data, i|
      ideas << Idea.new(data.merge("id" => i))
    end
    ideas
  end

  def self.raw_ideas
    database.transaction do |db|
      db['ideas'] || []
    end
  end

  def self.find_words(idea)
    # idea_search = []
    # raw_ideas.each do |words|
    #   idea_search << Idea.new(data.include?(words))
    # end
    # idea_search
    idea_search = []
    database.transaction do
      idea_search << database['ideas'].include?(idea)
    end
    "hello"
    idea_search
  end

  # def self.separate_words_in_idea(idea)
  #   idea_words = idea.split!
  #   idea_words
  # end

  def self.database
    return @database if @database

    @database ||= YAML::Store.new('db/ideabox')
    @database.transaction do
        @database['ideas'] ||= []
    end
    @database
  end

  def self.delete(position)
    database.transaction do
      database['ideas'].delete_at(position)
    end
  end

  def self.find(id)
    raw_idea = find_raw_idea(id)
    Idea.new(raw_idea.merge("id" => id))
  end

  def self.find_raw_idea(id)
    database.transaction do
      database['ideas'].at(id)
    end
  end

  def self.update(id, data)
    database.transaction do
      database['ideas'][id] = data
    end
  end

  def self.create(data)
    database.transaction do
      database['ideas'] << data
    end
  end
end