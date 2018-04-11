require 'pry'
class MusicLibraryController

  attr_accessor :path, :files

  def initialize(path = './db/mp3s')
    self.path = path
    importer = MusicImporter.new(path)
    # binding.pry
    # self.files = importer.files.collect {|file| file.gsub(".mp3","")}
    importer.import
  end

  def call
    reply = nil

    while reply != 'exit'
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      reply = gets

      case reply
      when 'list songs'
        list_songs
      when 'list artists'
        list_artists
      when 'list genres'
        list_genres
      when 'list artist'
        list_songs_by_artist
      when 'list genre'
        list_songs_by_genre
      when 'play song'
        play_song
      end
    end


  end

  def list_songs
    sorted = Song.all.sort_by {|song| song.name}.uniq!
    sorted.each_with_index { |file, index| puts "#{index + 1}. #{file.artist.name} - #{file.name} - #{file.genre.name}"}
  end

  def list_artists
    sorted = Artist.all.collect { |artist| artist.name }.sort!
    sorted.each_with_index { |artist, index| puts "#{index + 1}. #{artist}"}
  end

  def list_genres
    sorted = Genre.all.collect { |genre| genre.name }.sort!
    sorted.each_with_index { |genre, index| puts "#{index + 1}. #{genre}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets

    if Artist.find_by_name(artist)
      sorted = Artist.find_by_name(artist).songs.sort_by{ |song| song.name}
      return sorted.each_with_index {|song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets

    if Genre.find_by_name(genre)
      sorted = Genre.find_by_name(genre).songs.sort_by{ |song| song.name}
      return sorted.each_with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    number = gets
    number = number.to_i
    sorted = Song.all.sort_by {|song| song.name}.uniq!

    if number > 0 && number < sorted.size
      song = sorted[number-1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end
