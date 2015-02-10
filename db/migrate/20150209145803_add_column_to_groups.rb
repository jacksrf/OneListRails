class AddColumnToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :list_id, :integer
    add_column :items, :bought_id, :integer
  end
end
