class Addmoreforiegnkeys < ActiveRecord::Migration
  def change
    add_foreign_key :groups, :invites
  end
end
