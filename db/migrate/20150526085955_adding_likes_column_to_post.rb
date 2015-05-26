class AddingLikesColumnToPost < ActiveRecord::Migration
  def change
    add_column :posts, :likes_count, :integer, default: 0
  end
end
