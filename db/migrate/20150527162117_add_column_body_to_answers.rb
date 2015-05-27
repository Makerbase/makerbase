class AddColumnBodyToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :body, :text
  end
end
