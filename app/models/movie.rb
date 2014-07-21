class Movie < ActiveRecord::Base
  require 'open-uri'
  YOUTUBE_FEED_URL = 'http://gdata.youtube.com/feeds/api/videos/'

  has_many :comments, dependent: :destroy

  attr_accessible :url, :title
  validates_presence_of :url, :title

  before_validation :set_title

  private
  def set_title
    movie_data = open(YOUTUBE_FEED_URL + url).read
    self.title = Nokogiri::XML.parse(movie_data).css('title').text
  rescue => e
    puts "[ERROR]: #{e.message}"
    self.title = ''
  end
end
