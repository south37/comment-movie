class CommentsController < ApplicationController
  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new params[:comment]
    movie = Movie.find_by_url params[:movie][:url]
    movie.comments << @comment

    @comment.save!
  end
end
