class AddTutoToItems < ActiveRecord::Migration
  def change
    add_column :items, :tuto, :boolean, default: false
  end
end
