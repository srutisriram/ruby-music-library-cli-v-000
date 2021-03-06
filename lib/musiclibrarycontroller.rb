class MusicLibraryController
  attr_accessor :path, :library
  def initialize(path= "./db/mp3s")
    @path=path
    @importer = MusicImporter.new(path)
    @library = @importer.import
    @library
  end
  def call
    collect_songs
    puts "Hello and Welcome to the Music Library CLI! Your options are to 'list songs', 'list artists', 'list genres', 'play song', or 'exit'."
    input = gets.strip
    if input == "list songs"
      list_songs
      puts "Please enter 'play song' if you would like to play one of these songs."
      input = gets.strip
      if input == "play song"
        play_song
      end
    elsif input == "play song"
      play_song
    elsif input == "list artists"
      list_artists
      puts "Please enter an artist's name if you'd like to see a list of his/her songs."
      list_artist_songs
    elsif input == "list genres"
      list_genres
      puts "Please enter a genre name if you'd like to see a list of songs within the genre."
      list_genre_songs
    end
  end

  def collect_songs
    @array = []
    @filename_array = []
    @importer.files.each_with_index do |file, index|
      filename = file.split(".mp3")[0]
      @filename_array << filename
      @array << "#{index + 1}. #{filename}"
    end
  end
  def list_songs
    @array.each do |item|
      puts item
    end
  end
  def play_song
    puts "Which song would you like to play?"
      input = gets.strip.to_i
      index = input - 1
      song = @filename_array[index]
      puts "Playing #{song}"
      puts "Would you like to play another song ['play song'] or 'exit'?"
      input = gets.strip
      if input == "play song"
        play_song
      end
  end

  def list_artists
    @library.collect do |song|
      puts song.artist.name
    end
  end
  def list_artist_songs
    input = gets.strip
    artist = Artist.find_or_create_by_name(input)
    artist.songs.collect do |song|
      puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
    if input != "exit"
      input= gets.strip
    end
  end
  def list_genres
    @library.collect do |song|
      puts song.genre.name
    end
  end
  def list_genre_songs
    input = gets.strip
    genre = Genre.find_or_create_by_name(input)
    genre.songs.collect do |song|
      puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
    if input != "exit"
      input= gets.strip
    end
  end
end
