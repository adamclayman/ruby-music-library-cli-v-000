class Song
  attr_accessor :name, :artist, :genre

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

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end
end
