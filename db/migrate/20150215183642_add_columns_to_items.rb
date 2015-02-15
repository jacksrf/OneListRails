class AddColumnsToItems < ActiveRecord::Migration
  def change
    add_column :items, :quantity, :integer
    add_column :items, :quantity_bought, :integer
  end
end
