class EditInvites < ActiveRecord::Migration
  def change
    remove_column :invites, :invitee
    add_column :invites, :email, :text
  end
end
