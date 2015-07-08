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
#  crew                   :string           default("babyrice")
#  soja                   :integer          default(24)
#  life                   :integer          default(10)
#  x                      :integer
#  y                      :integer
#  world_id               :integer
#  lowername              :string
#  soja_updated_at        :datetime
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
  has_many :events
  has_many :received_events, class_name: 'Event', foreign_key: :other_user_id
  has_many :items
  has_many :item_types, -> { distinct }, through: :items
  validates :name, presence: true, uniqueness: true
  before_create { |user| user.lowername = user.name.downcase }

  after_create :born

  scope :in_area, ->(user) do
    where.not(id: user.id).
      where(world_id: user.world_id).
      where("x >= :min_x AND x <= :max_x AND y >= :min_y AND y <= :max_y",
        min_x: user.x - 2, max_x: user.x + 2,
        min_y: user.y - 2, max_y: user.y + 2
      )
  end

  def all_unread_events
    Event.where("(user_id = :user_id AND read = :unread)
      OR (other_user_id = :user_id AND read_other_user = :unread)",
      user_id:  self.id,
      unread:   false
    )
  end

  def born
    world = World.where('usercount < 50').order(usercount: :asc).limit(1).first
    self.world_id = world.id
    if world.users.empty?
      self.x = world.max_x / 2
      self.y = world.max_y / 2
    else
      set_position(world)
      while User.where(world_id: world.id, x: x, y: y).exists? || x >= world.max_x || x <= 0 || y >= world.max_y || y <= 0 do
        set_position(world)
      end
    end
    self.soja_updated_at = Time.now.at_beginning_of_hour
    self.soja = 48
    self.save

    #event of birth
    birth = Event.new
    birth[:name] = "birth"
    birth[:user_id] = self.id
    birth[:world_id] = self.world_id
    birth.save

    world.usercount += 1
    world.save
  end

  private

  def set_position(world)
    others = User.where(world_id: world.id)
    n      = others.sample
    self.x = rand((n.x - 2)..(n.x + 2))
    self.y = rand((n.y - 2)..(n.y + 2))
  end

end
