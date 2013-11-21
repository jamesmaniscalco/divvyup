class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :itemType_id
      t.integer :person_id

      t.timestamps
    end
  end
end
