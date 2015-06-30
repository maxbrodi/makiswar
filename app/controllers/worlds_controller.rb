class WorldsController < ApplicationController
  def show
    @x_player = current_user.x
    @y_player = current_user.y

    @x_shift = @x_player - 3
    @y_shift = @y_player - 3

    @players = User.in_area(current_user)

    @players_on_map = {}

    @players.each do |player|
      @players_on_map[("#{player[:x] - @x_shift}#{player[:y] - @y_shift}").to_sym] = player
    end

    # for x_ennemy in (@x_player - 2)..(@x_player + 2)
    #   for y_ennemy in (@y_player - 2)..(@y_player + 2)
    #     if User.where(x: x_ennemy,y: y_ennemy).any?
    #       @ennemy_name = User.where(x: x_ennemy,y: y_ennemy).first.name
    #       @ennemy_crew = User.where(x: x_ennemy,y: y_ennemy).first.crew
    #       @ennemy_x = x_ennemy
    #       @ennemy_y = y_ennemy
    #     else

    #     end
    #   end
    # end

  end
end
