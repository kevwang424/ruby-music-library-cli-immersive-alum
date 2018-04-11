require "pry"
require_relative "./concerns/findable.rb"

class Genre

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

  def artists
    collection = []
    songs.each {|song| collection << song.artist if !collection.include?(song.artist)}
    collection
  end

end
