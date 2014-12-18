require 'yaml/store'

class Idea
  include Comparable
  attr_reader :title, :description, :tag, :rank, :id

  def initialize(attributes = {})
    @title = attributes["title"]
    @description = attributes["description"]
    @tag = attributes["tag"] || []
    @rank = attributes["rank"] || 0
    @id = attributes["id"]
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
end
