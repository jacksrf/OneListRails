class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.text :name
      t.integer :creator_id
      t.boolean :single_list
      t.boolean :multi_list

      t.timestamps null: false
    end
  end
end
