class AddSojaUpdateAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :soja_updated_at, :datetime
  end
end
