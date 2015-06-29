class CreateItemTypes < ActiveRecord::Migration
  def change
    create_table :item_types do |t|
      t.string :name
      t.string :joke
      t.string :picture
      t.string :kind
      t.integer :consumption
      t.integer :life_impact
      t.integer :lifetime

      t.timestamps null: false
    end
  end
end
