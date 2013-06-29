class Movie < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  attr_accessible :url
end
