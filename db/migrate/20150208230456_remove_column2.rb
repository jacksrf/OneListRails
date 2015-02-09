class RemoveColumn2 < ActiveRecord::Migration
  def change
    add_column :invites, :name, :text
  end
end
