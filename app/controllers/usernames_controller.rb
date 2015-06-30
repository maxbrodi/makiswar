class UsernamesController < ApplicationController
  prepend_before_filter :require_no_authentication
  skip_before_action    :authenticate_user!

  def new
  end

  def create
    username = params[:username]

    if username.present?
      session[:username] = username
      redirect_to new_user_registration_path
    else
      flash[:alert] = "Please provide a username"
      render :new
    end
  end

  private

  def require_no_authentication
    if current_user
      flash[:alert] = I18n.t("devise.failure.already_authenticated")
      redirect_to after_sign_in_path_for(current_user)
    end
  end
end
