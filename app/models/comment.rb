class Comment < ActiveRecord::Base
  belongs_to :movie
  
  attr_accessible :message, :commented_time
end
