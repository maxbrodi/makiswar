# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  crew                   :string           default("Baby Rice")
#  soja                   :integer          default(24)
#  life                   :integer          default(10)
#  x                      :integer
#  y                      :integer
#  world_id               :integer
#  lowername              :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_world_id              (world_id)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :world
  validates :name, presence: true, uniqueness: true
  before_save { |user| user.lowername = user.name.downcase }

  scope :in_area, ->(user) do
    where(":world_id = 1 AND x >= :min_x AND x <= :max_x AND y >= :min_y AND y <= :max_y",
      world_id: user.world_id,
      min_x: user.x - 2, max_x: user.x + 2,
      min_y: user.y - 2, max_y: user.y + 2
    )
  end
end
