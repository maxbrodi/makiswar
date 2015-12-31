class FightsController < ApplicationController
  respond_to :js, only: [:update]
  before_action :check_notif, except: [:update]

  def show
    # Get attacker and defender
    @attacker = current_user
    @defender_id = params[:defender]
    @defender = User.find(@defender_id)
    # display lifebar of defender
    case @defender.life
    when 10 then @lifebar = "full"
    when 6..10 then @lifebar = "almostfull"
    when 5 then @lifebar = "half"
    when 2..5 then @lifebar = "low"
    when 1 then @lifebar = "verylow"
    else
      @lifebar = "verylow"
    end
    # Infos top
    @soja = current_user.soja
    sojajauge
    available_fight_items
    session[:old_crew] = params[:old_crew] if params[:old_crew]
    @old_crew = session[:old_crew]
    # fight background
    @fight_bg = current_user.world.background
  end

  def update

    @attacker = current_user
    @defender = User.find(params[:defender])
    @item_type_id = params[:item_type_id]
    @item = current_user.items.where(item_type_id: @item_type_id).first
    success =  rand(10) + 1
    @killed = false

    # check if defender already dead
    if @defender.life < 1
      @killed = true
      @defender.save
      show
    else

      if @item_type_id == 'chopsticks'
        if @attacker.soja >= 4
          if success > 1
            @defender.life -= 1
            @defender.save
            @success = true
            @message = t(".hearts_attack", count: 1)
            attack = Event.new
            attack[:name] = "attack"
            attack[:world_id] = @attacker.world_id
            attack[:user_id] = @attacker.id
            attack[:other_user_id] = @defender.id
            attack[:read] = true
            attack.save
          else
            @success = false
            @message = t(".hearts_attack", count: 0)
            missed = Event.new
            missed[:name] = "missed"
            missed[:world_id] = @attacker.world_id
            missed[:user_id] = @attacker.id
            missed[:other_user_id] = @defender.id
            missed[:read] = true
            missed.save
          end
          @attacker.soja -= 4
          @attacker.save
        end
      else
        if @attacker.soja >= @item.item_type.consumption
          if success > 1
            @defender.life -= @item.item_type.life_impact
            @defender.save
            @success = true
            @message = t(".hearts_attack", count: @item.item_type.life_impact)

            @item.broken_count += 1
            @item.save
            # bris d'objet
            if @item.broken_count >= @item.item_type.lifetime
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
              broken[:world_id] = @attacker.world_id
              broken[:user_id] = @attacker.id
              broken[:item_type_id] = @item.item_type.id
              broken.save

            end

            attack = Event.new
            attack[:name] = "attack"
            attack[:world_id] = @attacker.world_id
            attack[:user_id] = @attacker.id
            attack[:other_user_id] = @defender.id
            attack[:read] = true
            attack[:item_type_id] = @item.item_type.id
            attack.save
          else
            @success = false
            @message = t(".hearts_attack", count: 0)

            missed = Event.new
            missed[:name] = "missed"
            missed[:world_id] = @attacker.world_id
            missed[:user_id] = @attacker.id
            missed[:other_user_id] = @defender.id
            missed[:item_type_id] = @item.item_type.id
            missed[:read] = true
            # missed[:item_type_id] = item.item_type.id
            missed.save
          end
          @attacker.soja -= @item.item_type.consumption
          @attacker.save
        end
      end

      # Avocado/Salmon attribution
      case @attacker.crew
      when "babyrice"
        case @defender.crew
        when "avocado"
          @attacker.crew = "salmon"
          @attacker.save
        when "salmon"
          @attacker.crew = "avocado"
          @attacker.save
        else
          @attacker.crew = ["salmon", "avocado"].sample
          @attacker.save
        end

      change_crew_event(@attacker)

      when "bastardo"
        last_three_kills = @attacker.events.where(user_id: @attacker.id).where(name:"kill").last(3)
        three_crews = []
        last_three_kills.each do |event|
          three_crews << User.find(event[:other_user_id]).crew
        end
        if three_crews.uniq.length == 1
          new_opponent = three_crews.first
          case new_opponent
          when "salmon"
            @attacker.crew = "avocado"
            @attacker.save
            change_crew_event(@attacker)
          when "avocado"
            @attacker.crew = "salmon"
            @attacker.save
            change_crew_event(@attacker)
          end
        end
      when "salmon"
        if @defender.crew == "salmon"
          @attacker.crew = "bastardo"
          @attacker.save
          change_crew_event(@attacker)
        end
      when "avocado"
        if @defender.crew == "avocado"
          @attacker.crew = "bastardo"
          @attacker.save
          change_crew_event(@attacker)
        end
      end

      # After attack. See if opponent died
      if @defender.life < 1
        @killed = true
        # defender loses all items
        if @defender.items.count < 5
          lost_items = @defender.items
          random_items = []
        else
          lost_items = @defender.items.last(4)
          random_items = @defender.items.first(@defender.items.count - 4)
        end

        lost_items.each do |item|
          if item.tuto = false
            item.world_id = @defender.world_id
            item.x = @defender.x
            item.y = @defender.y
          end
            item.user_id = nil
            item.save
        end

        random_items.each do |item|
          if item.tuto = false
            item.world_id = @defender.world_id
            item.x = rand(1..current_user.world.max_x)
            item.y = rand(1..current_user.world.max_y)
            item.broken_count = 0
          end
            item.user_id = nil
            item.save
        end

        # defender dies
        @defender.world_id = nil
        @defender.x = nil
        @defender.y = nil
        @defender.save
        # kill event created
        kill = Event.new
        kill[:name] = "kill"
        kill[:world_id] = @attacker.world_id
        kill[:user_id] = @attacker.id
        kill[:other_user_id] = @defender.id
        kill[:read] = true
        kill[:read_other_user] = false
        # kill[:item_type_id] = item.item_type.id -> TO DO MAXIME
        kill.save
        # wasabi giver
        wasabi_giver(@attacker, @defender)
        # world usercount loses 1
        world = World.find(current_user.world_id)
        world.usercount -= 1
        world.save
      end
    end

    show
    available_fight_items
  end

  private

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

  def change_crew_event(user)
    crew_event = Event.new
    crew_event[:name] = user.crew
    crew_event[:user_id] = user.id
    crew_event[:world_id] = user.world_id
    crew_event.save
  end

  def available_fight_items
    @fight_item_types = current_user.item_types.where(kind: 'Attack').order(life_impact: :asc)
  end

  def set_item_position_after_broken
    @item.x = rand(1..current_user.world.max_x)
    @item.y = rand(1..current_user.world.max_y)
  end

  def set_ennemies
    case current_user.crew
    when "avocado" then @ennemies = "salmons"
    when "salmon" then @ennemies = "avocados"
    when "bastardo" then @ennemies = "everyone"
    end
  end

  def wasabi_giver(attacker, defender)
    if attacker.crew == "salmon" || attacker.crew == "avocado"
      set_ennemies
      case defender.crew
      when "babyrice"
        wasabi_won = 1
      when "bastardo"
        wasabi_won = 6
      when @ennemies
        wasabi_won = 5
      else
        wasabi_won = 0
      end
    else attacker.crew == "bastardo"
      if defender.crew == "babyrice"
        wasabi_won = 1
      else
        wasabi_won = 4
      end
    end
    attacker.wasabi += wasabi_won
    session[:wasabi_won] = wasabi_won
    attacker.save
  end

end
