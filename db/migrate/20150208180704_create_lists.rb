class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.text :name
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
