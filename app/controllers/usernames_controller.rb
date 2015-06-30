class UsernamesController < ApplicationController
  prepend_before_filter :require_no_authentication
  skip_before_action    :authenticate_user!

  def new
  end

  def create
    username = params[:username]
    check = User.where(lowername: username.downcase).first

    if username.present?
      if check.nil?
        session[:username] = username
        redirect_to new_user_registration_path
      else
        flash[:alert] = I18n.t("usernames.create.flash.alert.already_taken")
        render :new
      end
    else
      flash[:alert] = I18n.t("usernames.create.flash.alert.empty")
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
