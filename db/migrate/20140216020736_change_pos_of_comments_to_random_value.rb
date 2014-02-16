class ChangePosOfCommentsToRandomValue < ActiveRecord::Migration
  YtHeight = 280
  YtOffset = 80

  def up
    Comment.all.map do |comment|
      comment.position = YtOffset + rand(YtHeight)
      comment.save!
    end
  end

  def down
    Comment.all.map do |comment|
      comment.position = 300
      comment.save!
    end
  end
end
