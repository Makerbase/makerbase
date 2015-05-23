class DropRatingsTable < ActiveRecord::Migration
  def up
    drop_table :ratings
  end

  def down
    create_table :ratings
  end
end
