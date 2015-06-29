class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.boolean :read, default: false
      t.string :name
      t.references :world, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :other_user_id
      t.references :item, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_foreign_key :events, :users, column: :other_user_id
    add_index       :events, :other_user_id
  end
end
