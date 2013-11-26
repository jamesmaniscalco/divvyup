class AddFinishedFlagToItem < ActiveRecord::Migration
  def change
    add_column :items, :finished, :boolean
    add_column :items, :finished_at, :datetime
  end
end
