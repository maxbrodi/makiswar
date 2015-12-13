class AddTutotoWorlds < ActiveRecord::Migration
  def change
    add_column :worlds, :tuto, :boolean, default: true
  end
end
