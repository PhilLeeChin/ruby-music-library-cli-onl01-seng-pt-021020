class Artist
  extends Concerns::Findable
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(artist)
    @name = artist
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(artists)
    artists = self.new(artists)
    artists.save
    artists
  end

  def add_song(song)
    if song.artist == nil
      song.artist = self
    end
    if !@songs.include?(song)
      self.songs << song
    end
  end

  def genres
    songs.collect { |song| song.genre}.uniq
  end
end
