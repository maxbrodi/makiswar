class AddReadOtherUserChangeReadUserOfEvents < ActiveRecord::Migration
  def change
    add_column :events, :read_other_user, :boolean, default: false
  end
end
