class ChangeBabyRiceToSnailCase < ActiveRecord::Migration
  def change
    change_column :users, :crew, :string, default: "babyrice"
  end
end
