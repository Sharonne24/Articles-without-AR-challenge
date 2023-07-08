# Please copy/paste all three classes into this file to submit your solution!

#author.rb
class Author
    attr_reader :name
  
    def initialize(name)
      @name = name
    end
  
    def articles
      Article.all.select { |article| article.author == self }
    end
  
    def magazines
      articles.map(&:magazine).uniq
    end
  
    def add_article(magazine, title)
      Article.new(self, magazine, title)
    end
  
    def topic_areas
      magazines.map(&:category).uniq
    end
  end

  #magazine.rb

  class Magazine
    attr_accessor :name, :category
    @@all = []
  
    def initialize(name, category)
      @name = name
      @category = category
      @@all << self
    end
  
    def self.all
      @@all
    end
  
    def self.find_by_name(name)
      @@all.find { |magazine| magazine.name == name }
    end
  
    def article_titles
      Article.all.select { |article| article.magazine == self }.map(&:title)
    end
  
    def contributing_authors
      Article.all.each_with_object(Hash.new(0)) do |article, counts|
        counts[article.author] += 1 if article.magazine == self
      end.select { |author, count| count > 2 }.keys
    end
  
    def contributors
      Article.all.select { |article| article.magazine == self }.map(&:author).uniq
    end
  
    def topic_areas
      self.class.all.map(&:category).uniq
    end
  end

  #article.rb
  
  class Article
    attr_reader :author, :magazine, :title
    @@all = []

    def initialize(author, magazine, title)
        @author = author
        @magazine = magazine
        @title = title
        @@all << self
    end

    def self.all
        @@all
    end
end
