class RecapsController < ApplicationController
  def show

    if current_user.life < 1
      @dead = true
      death_event = Event.where(other_user_id:  current_user.id).last
      @killer = User.find(death_event[:user_id])
      death_event[:read_other_user] = true
      death_event.save
      # @weapon =
    else
      # @events = Event.find_by_sql(["SELECT * FROM events WHERE other_user_id = ? OR user_id > ? LIMIT 5", current_user.id, current_user.id])
      @events = current_user.all_events.unread
      @events = @events.flatten.reverse
      @events.each do |event|
        # check if change of crew
        if event[:name] == "salmon" || event[:name] == "avocado" || event[:name] == "bastardo"
          @change_crew = true
        end
        # mark all events as read
        if event[:user_id] == current_user.id
          event[:read] = true
        else
          event[:read_other_user] = true
        end
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

  private

  def custom_format(date)
    if date == Time.zone.now
      "Today"
    elsif date == Time.zone.now - 1.day
      "Yesterday"
    else
      "A long time ago"
    end
  end


end
