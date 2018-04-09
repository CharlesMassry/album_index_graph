class SongSearch
  def self.search(query)
    Song.where(title: /.*#{query}.*/i).to_a +
      Album.where(title: /.*#{query}.*/i).songs.to_a  +
      Artist.where(name: /.*#{query}.*/i).albums.songs.to_a
  end
end