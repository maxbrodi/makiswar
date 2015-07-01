class FightsController < ApplicationController
  def show

    # Get attacker and defender

    @attacker = session['attacker']
    @defender



    # Infos top

    @life = current_user.life
    @soja = current_user.soja

  end
end
