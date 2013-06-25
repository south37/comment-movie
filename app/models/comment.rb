class Comment < ActiveRecord::Base
  attr_accessible :message, :commented_time
end
