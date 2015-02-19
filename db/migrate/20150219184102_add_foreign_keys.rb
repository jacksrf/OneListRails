class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :items, :lists
    add_foreign_key :members, :groups
    add_foreign_key :multi_lists, :groups
  end
end
