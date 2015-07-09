class UsersController < ApplicationController
  def show
    my_backpack
  end

  def update
  end

  private

  def my_backpack
    @my_items_type = current_user.item_types.order(kind: :desc)
  end

end
