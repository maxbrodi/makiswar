class FightsController < ApplicationController

  def show

    # Get attacker and defender

    # A REMETTRE
    @attacker = current_user
    # @defender = session['defender']

    # COMBAT TEST - A CHANGER
    @defender_id = params[:defender]
    @defender = User.find(@defender_id)

    # Infos top

    @soja = current_user.soja

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
      @defender.world_id = nil
      @defender.x = nil
      @defender.y = nil
      @defender.save
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


end
