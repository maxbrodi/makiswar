class UsersController < ApplicationController
  def show
    my_backpack
  end

  def update

    # algo :
    # item.user_id = nil
    # item.world_id = current_user.world_id
    # item.x = current_user.x
    # item.y = current_user.y
    # item.save

  end

  private

  def my_backpack
    my_items_type = current_user.item_types.order(kind: :desc)
    #variable to display
    @mybackpack = {}
    @item_description = {}
    @allitems_count = 0
    # compute their value
    my_items_type.each do |item_type|
      @mybackpack[item_type] = current_user.items.where(item_type: item_type.id).count
      # count all items
      @allitems_count += @mybackpack[item_type]
      case item_type.kind
      when "Attack"
        @item_description[item_type] = "Attacks for " + item_type.consumption.to_s + " cl."
      when "Movement"
        @item_description[item_type] = "Moves for " + item_type.consumption.to_s + " cl."
      when "Useless"
        @item_description[item_type] = "Does nothing special."
      end
    end
    return @mybackpack
  end

end
