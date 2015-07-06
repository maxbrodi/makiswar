class FightsController < ApplicationController

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
      else
        @attacker.soja -= 4
        @attacker.save
        @success = false
        @message = t(".hearts_attack", count: 0)
      end
    end

    # After attack. See if opponent died

    if @defender.life < 1
      @killed = true

      lost_items = @defender.items
      lost_items.each do |item|
        item.world_id = @defender.world_id
        item.x = @defender.x
        item.y = @defender.y
        item.user_id = nil
        item.save
      end

      @defender.world_id = nil
      @defender.x = nil
      @defender.y = nil
      @defender.save
    end

    # update soja updated at date !

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

end
