class MoviesController < ApplicationController
  # GET /movies
  # GET /movies.json
  def index
    @movie    = Movie.find_or_create_by_url params[:url]
    @comments = @movie.comments
  end

  # POST /movies
  # POST /movies.json
  def create
    url   = params[:movie][:url].split('=').last
    movie = Movie.find_or_create_by_url url

    if movie.save
      redirect_to controller: 'movies', action: 'index', params: {url: movie.url}
    else
      redirect_to :root, flash: {class: 'alert alert-danger'}
    end
  end
end
