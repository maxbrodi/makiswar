class AddLowerCaseUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lowername, :string
  end
end
