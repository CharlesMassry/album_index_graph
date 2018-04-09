require 'httparty'
module Scrapers
  class SongScraper
    def print_and_log(msg)
      puts msg
      Rails.logger.info(msg)
    end

    include HTTParty
    API_KEY = ENV['LAST_FM_API_KEY']
    base_uri 'http://ws.audioscrobbler.com/2.0/'
    query_string_normalizer proc { |query|
      query.map do |key, value|
        "#{key}=#{value}"
      end.join('&')
    }

    def initialize(artist_name)
      raise ArgumentError, 'No API KEY' if !API_KEY || API_KEY.empty?
      @artist_name = artist_name
    end

    def db_insert
      artist = Artist.create(name: @artist_name)
      print_and_log("Creating Artist: #{artist.name}")
      top_albums = self.class.get('', {
          query: {
              method: 'artist.getTopAlbums',
              artist: @artist_name.gsub(/\s/, '+'),
              api_key: API_KEY,
              format: 'json'
          }
      }).parsed_response.dig('topalbums', 'album')

      top_albums.first(5).each do |album_response|
        album = Album.create({
                                 title: album_response['name'],
                                 album_art_url: album_response['image'].find { |image| image['size'] === 'medium' }['#text']
                             })
        print_and_log("Creating Album: #{album.title}")
        Contribution.create(to_node: album, from_node: artist, credit: "primary_artist")
        songs_response = self.class.get('', {
            query: {
                method: 'album.getInfo',
                artist: @artist_name.gsub(/\s/, '+'),
                album: album.title.gsub(/\s/, '+'),
                api_key: API_KEY,
                format: 'json'
            }
        }).parsed_response.dig('album', 'tracks', 'track')

        next unless songs_response.present?

        track_number = 1
        songs_response.each do |song_response|
          song = Song.create(
              title: song_response['name'],
              duration: song_response['duration'].to_i
          )
          print_and_log("Creating Song: #{song.title}")
          Track.create(from_node: album, to_node: song, track_number: track_number)
          track_number += 1
        end
      end
    end
  end
end
