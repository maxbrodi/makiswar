class AddWasabiToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wasabi, :integer, default: 0
  end
end
