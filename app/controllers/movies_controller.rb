class MoviesController < ApplicationController
  # GET /movies
  def index
    @movie = Movie.find_by_url params[:url]
    unless @movie
      redirect_to :root, flash: {class: 'alert alert-danger'}
    end
  end

  # POST /movies
  def create
    url    = params[:movie][:url].split('=').last
    @movie = Movie.find_or_initialize_by_url url

    if @movie.save
      redirect_to controller: 'movies', action: 'index', params: {url: @movie.url}
    else
      redirect_to :root, flash: {class: 'alert alert-danger'}
    end
  end
end
