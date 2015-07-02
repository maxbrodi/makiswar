class UsersController < ApplicationController
  def show
  end

  def update
    x_shift = current_user.x - 3
    y_shift = current_user.y - 3
    new_position = params[:new_position].split("")
    current_user.x = new_position[0].to_i + x_shift
    current_user.y = new_position[1].to_i + y_shift
    current_user.save
    redirect_to worlds_show_path
  end

  def collection
  end

  def stats
  end

end
