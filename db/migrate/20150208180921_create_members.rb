class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.text :name
      t.integer :group_id
      t.integer :list_id
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
