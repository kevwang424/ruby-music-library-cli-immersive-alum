require 'pry'
require_relative './concerns/findable.rb'

class Artist

  attr_accessor :name, :songs
  extend Concerns::Findable

  @@all = []

  def initialize(name)
    self.name = name
    self.songs = []
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

  def add_song(song)
    song.artist = self if song.artist == nil
    songs << song if !songs.include?(song)
  end

  def genres
    collection = []
    songs.each { |song| collection << song.genre if !collection.include?(song.genre)}
    collection
  end
end
