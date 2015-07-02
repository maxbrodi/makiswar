class FightsController < ApplicationController
  def show

    # Get attacker and defender

    # A REMETTRE
    # @attacker = session['attacker']
    # @defender = session['defender']

    # COMBAT TEST - A CHANGER
    @attacker = User.find(2)
    @defender = User.find(3)

    # Attaque à la baguette

    # if @attacker.soja > 4
    #   @defender.life -= 1
    #   @attacker.soja -= 4
    #   @message = "Defender lost 4 hearts!"
    # else
    #   @message = "You need more soy sauce... You\'ll get some soon!"
    # end



    # Infos top

    @life = current_user.life
    @soja = current_user.soja



  end

end
