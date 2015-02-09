class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :group_id
      t.integer :invitee
      t.integer :admin

      t.timestamps null: false
    end
  end
end
