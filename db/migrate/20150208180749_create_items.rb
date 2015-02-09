class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :name
      t.text :url
      t.text :price
      t.integer :list_id
      t.boolean :bought

      t.timestamps null: false
    end
  end
end
