class MoviesController < ApplicationController
  # GET /movies
  # GET /movies.json
  def index
    @movie = Movie.find_or_create_by_url params[:url]
    gon.movie_url = params[:url]
    @comments = @movie.comments

    @comment    = Comment.new
    @next_movie = Movie.new

    gon.comment_exists = true if @comments != []

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movie }
    end
  end

  # POST /movies
  # POST /movies.json
  def create
    url = params[:movie][:url].split('=').last
    @movie = Movie.new(url: url)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to controller: 'movies',
          action: 'index',
          params: {url: @movie.url}
        }
        format.json { render json: @movie, status: :created, location: @movie }
      else
        format.html { redirect_to :root, flash: {class: 'alert alert-danger'} }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end
end
