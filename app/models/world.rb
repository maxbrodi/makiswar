# == Schema Information
#
# Table name: worlds
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  background  :string
#  max_x       :integer
#  max_y       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  usercount   :integer          default(0)
#

class World < ActiveRecord::Base
  has_many :users
  has_many :events
  has_many :items
  validates :name, presence: true, uniqueness: true
  validates :background, presence: true
  validates :max_x, presence: true
  validates :max_y, presence: true
end
