class ChangeItemIdtoItemTypeIdInEvents < ActiveRecord::Migration
  def change
    remove_column :events, :item_id
    add_column :events, :item_type_id, :integer
  end
end
