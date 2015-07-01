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

  end
end
