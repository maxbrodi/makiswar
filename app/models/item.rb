# == Schema Information
#
# Table name: items
#
#  id           :integer          not null, primary key
#  x            :integer
#  y            :integer
#  world_id     :integer
#  user_id      :integer
#  item_type_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_items_on_item_type_id  (item_type_id)
#  index_items_on_user_id       (user_id)
#  index_items_on_world_id      (world_id)
#

class Item < ActiveRecord::Base
  belongs_to :world
  belongs_to :user
  belongs_to :item_type
  validates :item_type_id, presence: true
end
