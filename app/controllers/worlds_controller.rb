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

    # Translation
    @x_shift = @x_player - 3
    @y_shift = @y_player - 3
  end

  def translate_player_position
    @new_position = params[:new_position].split("")
    current_user.x = @new_position[0].to_i + @x_shift
    current_user.y = @new_position[1].to_i + @y_shift
    @item_types_id = params[:item_types_id]

    if @item_types_id == 'feet'
      @consumption = 4
    else
      item = current_user.items.where(item_types_id: @item_types_id).first
      # item. # decrement life
      @consumption = item.consumption
    end

    current_user.soja -= @consumption
    current_user.save

    @x_shift = current_user.x - 3
    @y_shift = current_user.y - 3
  end

  def available_move_items
    # @move_items = current_user.items.where(item_type_id: 2)
    @move_item_types = current_user.item_types.where(kind: 'Movement')
    # @move_items.each do |item|
    #   unless @move_items.include?(item.item_type.name)
    #     @move_items << item
    # end
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

  def check_notif
    return unless current_user

    if current_user.life < 1
      redirect_to recaps_show_path
    else
      lastevent = Event.find_by_sql(["SELECT * FROM events WHERE other_user_id = ? ORDER BY id DESC LIMIT 1", current_user.id]).first
      redirect_to recaps_show_path unless lastevent[:read]
    end
  end

end
