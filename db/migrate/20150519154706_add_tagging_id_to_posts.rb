class AddTaggingIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :tagging_id, :integer
  end
end
