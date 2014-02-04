class Movie < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  attr_accessible :url

  validates :url, presence: true
end
