class Profiles < ActiveRecord::Migration
  def change
    add_column :profiles, :current_password, :text
    add_column :profiles, :new_password, :text
    add_column :profiles, :confirm_password, :text
  end
end
