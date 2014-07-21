class AddTitleToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :title, :string, default: ''
  end
end
