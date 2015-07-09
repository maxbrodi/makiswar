class WorldsController < ApplicationController
  respond_to :js, only: [:update]
  before_action :check_notif

  def show
    set_player_position
    position_other_players_in_grid
    position_items_in_grid
    kinder_surprise
    set_world_info
    sojajauge
    available_move_items
  end

  def update
    set_player_position
    check_if_move_or_grab_update
    position_other_players_in_grid
    position_items_in_grid
    kinder_surprise
    set_world_info
    sojajauge
    available_move_items
  end

  private

  def set_player_position
    @x_player = current_user.x
    @y_player = current_user.y
    @x_shift = @x_player - 3
    @y_shift = @y_player - 3
  end

  def translate_player_position
    @item_type_id = params[:item_type_id]
    @new_position = params[:new_position].split("")
    current_user.x = @new_position[0].to_i + @x_shift
    current_user.y = @new_position[1].to_i + @y_shift
    if @item_type_id == 'feet'
      @consumption = 4
    else
      @item = current_user.items.where(item_type_id: @item_type_id).first
      @consumption = @item.item_type.consumption
      @item.broken_count += 1
      @item.save

      if @item.broken_count >= @item.item_type.lifetime
        @item.user_id = nil
        @item.world_id = current_user.world_id
        set_item_position_after_broken
        while User.where(world_id: @item.world_id, x: @item.x, y: @item.y).exists? do
          set_item_position_after_broken
        end
        @item.broken_count = 0
        @item.save

        # event d'objet casse
        broken = Event.new
        broken[:name] = "broken"
        broken[:world_id] = current_user.world_id
        broken[:user_id] = current_user.id
        broken[:item_type_id] = @item.item_type.id
        broken.save
      end
    end
    current_user.soja -= @consumption
    current_user.save
    @x_shift = current_user.x - 3
    @y_shift = current_user.y - 3
  end

  def available_move_items
    @move_item_types = current_user.item_types.where(kind: 'Movement').order(consumption: :desc)
  end

  def position_other_players_in_grid
    @players = User.in_area(current_user)
    @players_on_map = {}
    @players.each do |player|
     @players_on_map[("#{player[:x] - @x_shift}#{player[:y] - @y_shift}").to_sym] = player
    end
  end

  def position_items_in_grid
    @items = Item.in_area(current_user)
    @items_on_map = {}
    @items.each do |item|
      @items_on_map[("#{item[:x] - @x_shift}#{item[:y] - @y_shift}").to_sym] = item
    end
  end

  def kinder_surprise
    @kinder = Item.where(world_id: current_user.world_id, x: current_user.x, y: current_user.y)
  end

  def add_item_to_user
    item_id = params[:item_id]
    new_item = kinder_surprise.find(item_id)
    new_item.world_id = nil
    new_item.x = nil
    new_item.y = nil
    new_item.user_id = current_user.id
    new_item.save
  end

  def check_if_move_or_grab_update
    @choice = params[:choice]
    case @choice
    when "move" then translate_player_position
    when "grab" then add_item_to_user
    end
  end

  def set_world_info
    @life = current_user.life
    @soja = current_user.soja
    case current_user.crew
    when "avocado" then @ennemies = "salmons"
    when "salmon" then @ennemies = "avocados"
    when "bastardo" then @ennemies = "everyone, you bastard"
    when "babyrice" then @ennemies = "everyone"
    end
    @info = ".info" + (rand(5) + 1).to_s
  end

  def sojajauge
    @soja = current_user.soja
    case @soja
    when 0 then @jauge = "empty.png"
    when 1...3 then @jauge = "verylow.png"
    when 3...12 then @jauge = "low.png"
    when 12 then @jauge = "half.png"
    when 13...24 then @jauge = "almostfull.png"
    when 24 then @jauge = "full.png"
    when 25..48 then @jauge = "overfull.gif"
    end
  end

  def lifebar(player)
    case player.life
    when 10 then return "full"
    when 6..10 then return "almostfull"
    when 5 then return "half"
    when 2..5 then return "low"
    when 1 then return "verylow"
    end
  end

  def set_item_position_after_broken
    @item.x = rand(1..current_user.world.max_x)
    @item.y = rand(1..current_user.world.max_y)
  end

end
