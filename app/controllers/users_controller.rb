class UsersController < ApplicationController
  def show
    my_backpack
  end

  def update
  end

  private

  def my_backpack
    @my_items = current_user.items
  end

end
