class WorldsController < ApplicationController
  respond_to :js, only: [:update]

  def show
    set_player_position
    position_other_players_in_grid
    set_world_info
    sojajauge
  end

  def update

    set_player_position
    translate_player_position
    position_other_players_in_grid
    set_world_info
    sojajauge

    respond_to do |format|
      format.js
    end
  end

  private

  def set_player_position
    @x_player = current_user.x
    @y_player = current_user.y

    # Translation
    @x_shift = @x_player - 3
    @y_shift = @y_player - 3
  end

  def translate_player_position
    @new_position = params[:new_position].split("")
    current_user.x = @new_position[0].to_i + @x_shift
    current_user.y = @new_position[1].to_i + @y_shift
    current_user.save

    @x_shift = current_user.x - 3
    @y_shift = current_user.y - 3
  end

  def position_other_players_in_grid
    @players = User.in_area(current_user)
    @players_on_map = {}

    @players.each do |player|
     @players_on_map[("#{player[:x] - @x_shift}#{player[:y] - @y_shift}").to_sym] = player
    end
  end

  def set_world_info
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

  def lifebar(player)

    case player.life
    when 10
      return "full"
    when 6..10
      return "almostfull"
    when 5
      return "half"
    when 2..5
      return "low"
    when 1
      return "verylow"
    end
  end

end
