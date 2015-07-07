class RecapsController < ApplicationController
  def show

    if current_user.life < 1
      @dead = true
      death_event = Event.where(other_user_id:  current_user.id).last
      @killer = User.find(death_event[:user_id])
      death_event[:read] = true
      death_event.save
      # @weapon =
    else
      # @events = Event.find_by_sql(["SELECT * FROM events WHERE other_user_id = ? OR user_id > ? LIMIT 5", current_user.id, current_user.id])
      @events = Event.find_by_sql(["SELECT * FROM events WHERE other_user_id = ? ORDER BY id DESC LIMIT 5", current_user.id])
      @events = @events.flatten.reverse
      @events.each do |event|
        event[:read] = true
        event.save
      end
    end

  end

  def update

    current_user.born

    current_user.soja = 24
    current_user.life = 10
    current_user.save

    redirect_to worlds_show_path
  end
end
