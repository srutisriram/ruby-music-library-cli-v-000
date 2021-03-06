class Genre
  attr_accessor :name
  @@all = []
  extend Concerns::Findable
  def initialize(name)
    @name=name
    @songs = []
  end
  def self.all
    @@all
  end
  def self.destroy_all
    @@all.clear
  end
  def save
    if
      @@all.collect do |genre|
        genre.name
      end.include?(self.name)
      @@all
    else
      @@all << self
    end
  end
  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end
  def songs
    @songs
  end
  def artists
    self.songs.collect do |song|
      song.artist
    end.uniq
  end
end
