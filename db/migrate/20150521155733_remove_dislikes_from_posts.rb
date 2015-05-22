class RemoveDislikesFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :dislikes, :integer
  end
end
