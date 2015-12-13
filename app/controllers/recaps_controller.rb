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
      @events = current_user.all_unread_events
      @events = @events.flatten.reverse
      @events.each do |event|
        # check if change of crew
        if event[:name] == "salmon" || event[:name] == "avocado" || event[:name] == "bastardo"
          @change_crew = true
          @new_crew = event[:name]
          set_ennemies
          case session[:old_crew]
          when "salmon"
            @old_crew = "salmon"
          when "avocado"
            @old_crew = "avocado"
          when "babyrice"
            @old_crew = "babyrice"
          when "bastardo"
            @old_crew = "bastardo"
          end
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

    current_user.soja = 50
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

  def set_ennemies
    case current_user.crew
    when "avocado" then @ennemies = "salmons"
    when "salmon" then @ennemies = "avocados"
    when "bastardo" then @ennemies = "everyone"
    end
  end


end
