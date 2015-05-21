class AddUserIdToCodereviews < ActiveRecord::Migration
  def change
    add_column :codereviews, :user_id, :integer
  end
end
