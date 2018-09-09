class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
    @files = []
  end

  def files
    globber = self.path + '/*.mp3'
    Dir.glob(globber).each do |mp3_file_path|
      mp3_file = mp3_file_path.split('/')[-1]
      @files << mp3_file
    end
    @files
  end

  def show_files
    @files
  end

  def show_files_alphabetized_by_song_name
    @files.sort_by {|file| file.split(" - ")[1]}
  end

  def show_artists
    @artists = @files.collect {|file| file.split(" - ")[0]}
    @artists.uniq.sort!
  end

  def import
    self.files.each do |filename|
      Song.create_from_filename(filename)
    end
  end
end
