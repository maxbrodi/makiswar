class CreateWorlds < ActiveRecord::Migration
  def change
    create_table :worlds do |t|
      t.string :name
      t.string :description
      t.string :background
      t.integer :max_x
      t.integer :max_y

      t.timestamps null: false
    end
  end
end
