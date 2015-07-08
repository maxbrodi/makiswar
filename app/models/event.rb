# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  read            :boolean          default(FALSE)
#  name            :string
#  world_id        :integer
#  user_id         :integer
#  other_user_id   :integer
#  item_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  read_other_user :boolean          default(FALSE)
#
# Indexes
#
#  index_events_on_item_id        (item_id)
#  index_events_on_other_user_id  (other_user_id)
#  index_events_on_user_id        (user_id)
#  index_events_on_world_id       (world_id)
#

class Event < ActiveRecord::Base
  belongs_to :event_type
  belongs_to :world
  belongs_to :user
  belongs_to :other_user, class_name: "User"
  belongs_to :item

  validates :name, presence: true
  validates :user_id, presence: true
  validates :world_id, presence: true
end
