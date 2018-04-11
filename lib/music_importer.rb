require 'pry'

class MusicImporter

  attr_accessor :path

  def initialize(path)
    self.path = path
  end

  def files
    filenames = Dir.entries(path)
    2.times { filenames.shift }
    filenames
  end

  def import
    files.each { |file| Song.create_from_filename(file) }
  end
end
