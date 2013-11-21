class CreateUses < ActiveRecord::Migration
  def change
    create_table :uses do |t|
      t.integer :person_id
      t.integer :item_id
      t.string :unit
      t.float :amount

      t.timestamps
    end
  end
end
