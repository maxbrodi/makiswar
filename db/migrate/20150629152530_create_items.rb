class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :x
      t.integer :y
      t.references :world, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :item_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
