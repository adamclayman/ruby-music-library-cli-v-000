require 'pry'

class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.create(name)
    obj = self.new(name)
    obj.save
    obj
  end

  def add_song(song)
    if (self.songs.detect {|o| o == song} == nil)
      @songs << song
    end
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end
end
