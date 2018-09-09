require 'pry'

class MusicLibraryController
  attr_accessor :path, :importer

  def initialize(path = "./db/mp3s")
    @path = path
    @importer = MusicImporter.new(self.path)
    @importer.import
  end

  def call
    i = "input"
    until i == "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      i = gets.chomp
    end

    case i
    when "exit"

    else
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      i = gets.chomp
    end
  end

  def list_songs
    @importer.show_files_alphabetized_by_song_name.each_with_index do |filename, i|
      puts "#{i + 1}. #{filename.split(".")[0]}"
    end
  end

  def list_artists
    artist_list = Artist.all.sort_by {|artist| artist.name}
    artist_list.each_with_index do |artist, i|
      puts "#{i + 1}. #{artist.name}"
    end
  end

  def list_genres
    genre_list = Genre.all.sort_by {|genre| genre.name}
    genre_list.each_with_index do |genre, i|
      puts "#{i + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.chomp
    song_list = Song.all.select {|song| song.artist.name == artist_name}
    song_list.sort_by! {|song| song.name}
    song_list.each_with_index do |song, i|
      puts "#{i+1}. #{song.name} - #{song.genre.name}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.chomp
    genre_list = Genre.all.select {|genre| genre.name == genre_name}
    songs_list = genre_list.collect {|genre| genre.songs}
    songs_list.flatten!
    songs_list.uniq!
    songs_list.sort_by! {|song| song.name}
    songs_list.each_with_index do |song, i|
      puts "#{i+1}. #{song.artist.name} - #{song.name}"
    end
  end

  def play_song
    self.list_songs
    song_number = 0
    until ((song_number.is_a? Integer ) && (song_number >= 1) && (song_number <= Song.all.length))
      puts "Which song number would you like to play?"
      song_number = gets.chomp
    end
    @importer.show_files_alphabetized_by_song_name.each_with_index do |filename, i|
      raw_data = filename.split(".mp3")[0].split(" - ")
      puts "Playing #{raw_data[1]} by #{raw_data[0]}"
    end
  end
end
