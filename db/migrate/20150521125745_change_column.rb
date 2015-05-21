class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :posts, :likes, :integer, :default => 0, :null => false
  end
end
