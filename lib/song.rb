require 'pry'

class Song
  attr_accessor :name, :artist
  attr_reader :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    @artist = artist
    @genre = genre
  end

  def self.all
    @@all
  end

  def self.create(name, artist = nil, genre = nil)
    obj = self.new(name, artist, genre)
    obj.save
    obj
  end

  def self.find_by_name(song_name)
    self.all.find {|song| song.name == song_name}
  end

  def self.find_or_create_by_name(song_name, artist = nil, genre = nil)
    if self.find_by_name(song_name) != nil
      self.find_by_name(song_name)
    else
      self.create(name, artist, genre)
    end
  end

  def artist=(artist_name)
    @artist = Artist.find_or_create_by_name(artist_name)
    Artist.add_song(self)
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
