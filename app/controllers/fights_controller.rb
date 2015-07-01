class FightsController < ApplicationController
  def show

    # Get attacker and defender

    # A REMETTRE
    # @attacker = session['attacker']
    # @defender = session['defender']

    # COMBAT TEST - A CHANGER
    @attacker = User.find(2)
    @defender = User.find(3)


    # Infos top

    @life = current_user.life
    @soja = current_user.soja

  end
end
