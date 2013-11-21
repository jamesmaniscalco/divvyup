class FixItemTypeColumnName < ActiveRecord::Migration
  def change
    rename_column :items, :itemType_id, :item_type_id
  end
end
