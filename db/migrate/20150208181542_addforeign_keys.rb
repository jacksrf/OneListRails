class AddforeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :items, :lists
    add_foreign_key :members, :groups
    add_foreign_key :lists, :users
  end
end
