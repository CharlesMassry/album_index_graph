require 'scrapers/song_scraper'

namespace :scrapers do
  desc 'Scrapes the artist, albums, and song from the last fm api for the given artist'
  task :artist_scraper, [:artist_name] => :environment do |t, args|
    Scrapers::SongScraper.new(args[:artist_name]).db_insert
  end

  desc 'Scrapes the artist, albums, and song from the last fm api for preselected artists'
  task song_scraper: :environment do
    [
        'blink-182',
        'Brand New',
        'Chance the Rapper',
        'Drake',
        'Fetty Wap',
        'Gym Class Heroes',
        'Katy Perry',
        'Kendrick Lamar',
        'Lady Gaga',
        'Motion City Soundtrack',
        'Taking Back Sunday',
        'Taylor Swift',
        'Yo Gotti'
    ].each do |artist_name|
      Scrapers::SongScraper.new(artist_name).db_insert
    end
  end
end
