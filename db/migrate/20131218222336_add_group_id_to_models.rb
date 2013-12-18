class AddGroupIdToModels < ActiveRecord::Migration
  def change
    add_column :items, :group_id, :integer
    add_column :item_types, :group_id, :integer
    add_column :people, :group_id, :integer
    add_column :uses, :group_id, :integer
  end
end
