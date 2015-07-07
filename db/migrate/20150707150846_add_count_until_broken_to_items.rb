class AddCountUntilBrokenToItems < ActiveRecord::Migration
  def change
    add_column :items, :broken_count, :integer
  end
end
