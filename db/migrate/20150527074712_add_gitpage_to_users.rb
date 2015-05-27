class AddGitpageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gitpage, :string
  end
end
