class AddUserCountToWorlds < ActiveRecord::Migration
  def change
    add_column :worlds, :usercount, :integer, default: 0
  end
end
