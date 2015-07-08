class FightsController < ApplicationController

  before_action :check_notif

  def show

    # Get attacker and defender

    # A REMETTRE
    @attacker = current_user
    # @defender = session['defender']

    # COMBAT TEST - A CHANGER
    @defender_id = params[:defender]
    @defender = User.find(@defender_id)
    case @defender.life
    when 10
      @lifebar = "full"
    when 6..10
      @lifebar = "almostfull"
    when 5
      @lifebar = "half"
    when 2..5
      @lifebar = "low"
    when 1
      @lifebar = "verylow"
    end

    # Infos top

    @soja = current_user.soja
    sojajauge

  end

  def update

    # Attaque à la baguette
    @attacker = current_user

    @defender = User.find(params[:defender])
    success =  rand(10) + 1
    @killed = false

    if @attacker.soja > 3
      if success > 1
        @defender.life -= 1
        @defender.save
        @attacker.soja -= 4
        @attacker.save
        @success = true
        @message = t(".hearts_attack", count: 1)

        #event attack
        attack = Event.new
        attack[:name] = "attack"
        attack[:world_id] = @attacker.world_id
        attack[:user_id] = @attacker.id
        attack[:other_user_id] = @defender.id
        attack[:read] = true
        # AJOUTER l'OBJET DE l'ATTAQUE
        # attack[:item_id] =
        attack.save
      else
        @attacker.soja -= 4
        @attacker.save
        @success = false
        @message = t(".hearts_attack", count: 0)

        #event missed
        missed = Event.new
        missed[:name] = "missed"
        missed[:world_id] = @attacker.world_id
        missed[:user_id] = @attacker.id
        missed[:other_user_id] = @defender.id
        # AJOUTER l'OBJET DE l'ATTAQUE RATEE
        # missed[:item_id] =
        missed.save

      end
    end

    # Avocado/Salmon attribution

    case @attacker.crew
    when "babyrice"
      case @defender.crew
      when "avocado"
        @attacker.crew = "salmon"
        @attacker.save
      when "salmon"
        @attacker.crew = "avocado"
        @attacker.save
      else
        @attacker.crew = ["salmon", "avocado"][rand(2)]
        @attacker.save
      end
    crew_event = Event.new
    crew_event[:name] = "#{@attacker.crew}"
    crew_event[:user_id] = @attacker.id
    crew_event[:world_id] = @attacker.world_id
    crew_event.save
    # when "salmon"
    # when "avocado"
    # when "bastardo"
    end


    # After attack. See if opponent died

    if @defender.life < 1
      @killed = true

      # defender loses all items
      lost_items = @defender.items
      lost_items.each do |item|
        item.world_id = @defender.world_id
        item.x = @defender.x
        item.y = @defender.y
        item.user_id = nil
        item.save
      end

      # defender dies
      @defender.world_id = nil
      @defender.x = nil
      @defender.y = nil
      @defender.save

      # death event created
      death = Event.new
      death[:name] = "death"
      death[:world_id] = @attacker.world_id
      death[:user_id] = @attacker.id
      death[:other_user_id] = @defender.id
      # AJOUTER l'OBJET DU KILL
      # death[:item_id] =
      death.save


    end

    show

    respond_to do |format|
      format.js
    end



    # version items
    # @soja_needed
    # @dammage_infliged

    # if @attacker.soja > @soja_needed
    #   success = rand(10) + 1
    #   if success > 1
    #     @defender.life -= @dammage_infliged
    #     @attacker.soja -= @soja_needed
    #     @message = t(".hearts_attack", count: 1)
    #   else
    #     @message = t(".hearts_attack", count: 0)
    #   end
    # end


  end

  private

  def sojajauge
    @soja = current_user.soja

    case @soja
    when 0
      @jauge = "empty.png"
    when 1...3
      @jauge = "verylow.png"
    when 3...12
      @jauge = "low.png"
    when 12
      @jauge = "half.png"
    when 13...24
      @jauge = "almostfull.png"
    when 24
      @jauge = "full.png"
    when 25..48
      @jauge = "overfull.gif"
    end
  end

  def check_notif
    return unless current_user

    if current_user.life < 1
      redirect_to recaps_show_path
    else
      lastevent_user = Event.find_by_sql(["SELECT * FROM events WHERE user_id = ? ORDER BY id DESC LIMIT 1", current_user.id]).first
      lastevent_otheruser = Event.find_by_sql(["SELECT * FROM events WHERE other_user_id = ? ORDER BY id DESC LIMIT 1", current_user.id]).first
      if (lastevent_user && lastevent_otheruser)
        redirect_to recaps_show_path unless (lastevent_user[:read] && lastevent_otheruser[:read])
      end
    end
  end

end
