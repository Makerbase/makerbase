class AddAuthorToPost < ActiveRecord::Migration
  def change
    add_column :posts, :author, :string
  end
end
