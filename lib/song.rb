class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(song, artist = nil, genre = nil)
    @name = song
    self.artist = artist if artist
    self.genre = genre if genre
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

  def self.create(songs)
    songs = self.new(songs)
    self.all << songs
    songs
  end

  def artist= (artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre= (genre)
    @genre = genre
    if !(genre.songs.include?(self))
      genre.songs << self
    end
  end

  # def self.find_by_name(name)
  #   all.detect{|a| a.name == name}
  # end
  #
  # def self.find_or_create_by_name(name)
  #   self.find_by_name(name) || self.create(name)
  # end

  def self.new_from_filename(name)
    artist, song, genre = name.split(' - ')
    fix = genre.gsub('.mp3', '')
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(fix)
    new(song, artist, genre)
  end
end
