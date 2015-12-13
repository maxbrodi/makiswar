class CreateTutoWorlds < ActiveRecord::Migration
  def change
    create_table :tuto_worlds do |t|
      t.integer :max_x
      t.integer :max_y

      t.timestamps null: false
    end
  end
end
