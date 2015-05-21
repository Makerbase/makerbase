class ChangeColumnDislikes < ActiveRecord::Migration
  def change
    change_column :posts, :dislikes, :integer, :default => 0, :null => false
  end
end
