class AddUserIdToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :user, index: true, foreign_key: true
    add_index :questions, [:user_id, :created_at]
  end
end
