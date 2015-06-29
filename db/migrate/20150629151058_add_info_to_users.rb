class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :crew, :string, default: "Baby Rice"
    add_column :users, :soja, :integer, default: 24
    add_column :users, :life, :integer, default: 10
    add_column :users, :x, :integer
    add_column :users, :y, :integer
    add_reference :users, :world, index: true
  end
end
