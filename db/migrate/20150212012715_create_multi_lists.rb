class CreateMultiLists < ActiveRecord::Migration
  def change
    create_table :multi_lists do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :list_id

      t.timestamps null: false
    end
  end
end
