class AddPositionToComments < ActiveRecord::Migration
  def change
    add_column :comments, :position, :float, default: 300
  end
end
