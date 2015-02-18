class AddEmailtologincheck < ActiveRecord::Migration
  def change
    add_column :logins, :email, :text
  end
end
