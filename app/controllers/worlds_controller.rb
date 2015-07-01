class WorldsController < ApplicationController
  def show
    @x_player = current_user.x
    @y_player = current_user.y

    # Translation
    @x_shift = @x_player - 3
    @y_shift = @y_player - 3

    @players = User.in_area(current_user)

    @players_on_map = {}

    @players.each do |player|
      @players_on_map[("#{player[:x] - @x_shift}#{player[:y] - @y_shift}").to_sym] = player
    end

    # Infos top

    @life = current_user.life
    @soja = current_user.soja

    # ennemies

    case current_user.crew
    when "avocado"
      @ennemies = "salmons"
    when "salmon"
      @ennemies = "avocados"
    when "bastardo"
      @ennemies = "everyone, you bastard"
    when "babyrice"
      @ennemies = "everyone"
    end

    # info

    @info = ".info" + (rand(5) + 1).to_s

  end
end
