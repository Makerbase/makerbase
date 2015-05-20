class CreateCodereviews < ActiveRecord::Migration
  def change
    create_table :codereviews do |t|
      t.string :title
      t.string :url

      t.timestamps null: false
    end
  end
end
