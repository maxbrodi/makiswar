# == Schema Information
#
# Table name: item_types
#
#  id          :integer          not null, primary key
#  name        :string
#  joke        :string
#  picture     :string
#  kind        :string
#  consumption :integer
#  life_impact :integer
#  lifetime    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ItemType < ActiveRecord::Base
  has_many :items
  validates :name, presence: true, uniqueness: true
  validates :joke, presence: true
  validates :picture, presence: true
  validates :kind, presence: true
  validates :lifetime, presence: true
end
