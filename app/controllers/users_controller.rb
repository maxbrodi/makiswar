class UsersController < ApplicationController
  respond_to :js, only: [:update]

  def show
    my_backpack
  end

  def update

    typeid = params[:item_type_id]

    item = Item.where(user_id: current_user.id, item_type_id: typeid).first

    item.user_id = nil
    item.world_id = current_user.world_id
    item.x = current_user.x
    item.y = current_user.y
    item.save

    my_backpack
  end

  private

  def my_backpack
    my_items_type = current_user.item_types.order(kind: :desc)
    #variable to display
    @mybackpack = {}
    @item_description = {}
    @item_t_id = {}
    @allitems_count = 0
    # compute their value
    my_items_type.each do |item_type|
      @mybackpack[item_type] = current_user.items.where(item_type: item_type.id).count
      # count all items
      @allitems_count += @mybackpack[item_type]
      @item_t_id[item_type] = item_type.id
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
