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
    tuto
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
    tuto
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
        # normal items
        if @item.tuto = false
          @item.user_id = nil
          @item.world_id = current_user.world_id
          set_item_position_after_broken
          while User.where(world_id: @item.world_id, x: @item.x, y: @item.y).exists? do
            set_item_position_after_broken
          end
          @item.broken_count = 0
          @item.save
        # items spawned for the tutoriel that must disappear
        else
          @item.user_id = nil
          @item.save
        end

        # event d'objet casse
        broken = Event.new
        broken[:name] = "broken"
        broken[:world_id] = current_user.world_id
        broken[:user_id] = current_user.id
        broken[:item_type_id] = @item.item_type.id
        broken[:read] = false
        broken.save
      end
    end
    current_user.soja -= @consumption
    current_user.save
    @x_shift = current_user.x - 3
    @y_shift = current_user.y - 3
  end

  def available_move_items
    @move_item_types = current_user.item_types.where(kind: 'Movement').order(consumption: :asc)
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
    if current_user.items.count < 9
      new_item = kinder_surprise.find(item_id)
      new_item.world_id = nil
      new_item.x = nil
      new_item.y = nil
      new_item.user_id = current_user.id
      new_item.save
    end
  end

  def check_if_move_or_grab_update
    @choice = params[:choice]
    case @choice
    when "move" then translate_player_position
    when "grab" then add_item_to_user
    end
  end

  def set_world_info
    # background info
    @world_background = current_user.world.background
    @max_x =  current_user.world.max_x
    @max_y =  current_user.world.max_y
    # user infos
    @life = current_user.life
    @soja = current_user.soja
    case current_user.crew
    when "avocado" then @ennemies = "salmons"
    when "salmon" then @ennemies = "avocados"
    when "bastardo" then @ennemies = "everyone, you bastard"
    when "babyrice" then @ennemies = "everyone"
    end
    @info = ".info" + (rand(10) + 1).to_s
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
    when 25..50 then @jauge = "overfull.gif"
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

  def tuto
    if current_user.world.tuto
      case current_user.x
      when 1
        @tuto_text = "Hey! Touch the cell next to " + current_user.name + " to move there!"
      when 2
        if current_user.items.count == 0
          @tuto_text = "Wow! So cool! <br>  Keep going right!"
        else
          @tuto_text = "If I were you, I'd go right."
        end
      when 3
        if current_user.items.count == 0
          @tuto_text = "Wait! Is that a box on your right? <br> Go check it out."
        else
          @tuto_text = "You should keep going right, little maki."
        end

      when 4
        if current_user.items.count == 0
          @tuto_text = "Touch the bouncing box to see what\'s inside!"
        else
          @tuto_text = "Nice items! <br> You can now go further and hit harder!"
        end
      when 5
        @tuto_text = "Each move or attack you make costs some soy sauce."
      when 6
        @tuto_text = "Let\'s teleport so I can explain you something, " + current_user.name + "."
      # in case user goes to far by using several browsers
      when 7
        @tuto_text = "WOOOW! Reload the page please!"
        current_user.x = 6
        current_user.save
      end
      # in case user goes back and lacks soy sauce
      if current_user.soja < 5
        current_user.soja = 50
        current_user.save
      end
    end
  end

  def livenews
    lastevents = Event.last(5)
    lastevents.each do |event|
      event.name
    end
  end

end
