class AddTaggingIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :tagging_id, :integer
  end
end
