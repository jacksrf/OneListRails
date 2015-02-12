class Addcolumnstomembersandinvites < ActiveRecord::Migration
  def change
    add_column :invites, :multi_list, :boolean
    add_column :members, :user_id, :integer
  end
end
