require 'pry'

class Song
  attr_accessor :name
  attr_reader :genre, :artist

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    @artist = artist if artist != nil
    @genre = genre if genre != nil
  end

  def self.all
    @@all
  end

  def self.create(name, artist = nil, genre = nil)
    obj = self.new(name, artist, genre)
    obj.save
    obj
  end
  
  def artist=(artist_name)
    @artist = Artist.find_or_create_by_name(artist_name)
    @artist.add_song(self)
  end

  def genre=(genre_name)
    @genre = Genre.find_or_create_by_name(genre_name)
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end
end
