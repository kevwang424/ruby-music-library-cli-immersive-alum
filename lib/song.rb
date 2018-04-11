require 'pry'

class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    self.name = name
    self.artist = artist
    self.genre = genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    new_instance = self.new(name)
    new_instance.save
    new_instance
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self) if artist != nil
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self if genre!= nil && !genre.songs.include?(self)
  end

  def self.find_by_name(name)
    self.all.find {|song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  end

  def self.new_from_filename(filename)
    parsed = filename.split(" - ")
    song = self.find_or_create_by_name(parsed[1])
    song.artist = Artist.find_or_create_by_name(parsed[0])
    song.genre = Genre.find_or_create_by_name(parsed[2].gsub(".mp3",""))
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
  end
end
