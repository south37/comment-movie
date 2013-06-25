class AddCommentedTimeToComments < ActiveRecord::Migration
  def change
    add_column :comments, :commented_time, :integer, default: 1000
  end
end
