class AddSubtitlecolumn < ActiveRecord::Migration
  def change
    add_column :groups, :subtitle, :text
  end
end
