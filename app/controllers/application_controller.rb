# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def new_movie
    session[:movie_url] = params[:url]
    movie = Movie.find_by_url(session[:movie_url])
    return movie if movie

    movie = Movie.create(url: session[:movie_url])
  end
end
