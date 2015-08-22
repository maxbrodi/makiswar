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
#  broken_count :integer
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

  scope :in_area, ->(item) do
    where(world_id: item.world_id).
    where("x >= :min_x AND x <= :max_x AND y >= :min_y AND y <= :max_y",
      min_x: item.x - 2, max_x: item.x + 2,
      min_y: item.y - 2, max_y: item.y + 2
    )
  end

end
