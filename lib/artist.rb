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
    song.artist = self if song.artist == nil
    @songs << song if @songs.find {|song_match| song_match.name == song.name} == nil
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end
end
