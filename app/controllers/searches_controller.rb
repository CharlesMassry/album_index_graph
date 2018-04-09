class SearchesController < ApplicationController
  def index

  end

  def show
    @songs = SongSearch.search(params.dig(:search, :query))
  end
end
