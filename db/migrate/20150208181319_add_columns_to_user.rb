class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :text
    add_column :users, :last_name, :text
    add_column :users, :address, :text
    add_column :users, :address2, :text
    add_column :users, :city, :text
    add_column :users, :state, :text
    add_column :users, :zip, :text
    add_column :users, :email, :text
    add_column :users, :phone, :text
  end
end
