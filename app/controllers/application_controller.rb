class ApplicationController < ActionController::Base
  # include Pundit
  before_action :set_locale
  protect_from_forgery with: :exception

  before_action :authenticate_user!, unless: :pages_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :get_soja

  # after_action :verify_authorized, except:  :index, unless: :devise_or_pages_controller?
  # after_action :verify_policy_scoped, only: :index, unless: :devise_or_pages_controller?

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def after_sign_in_path_for(resource)
    worlds_show_path
  end

  def check_notif
    return unless current_user

    if current_user.life < 1 || current_user.all_events.unread.exists?
      redirect_to recaps_show_path
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  def devise_or_pages_controller?
    devise_controller? || pages_controller?
  end

  def pages_controller?
    controller_name == "pages"  # Brought by the `high_voltage` gem
  end

  def get_soja
    return unless current_user

    soja_to_add = ((Time.now - current_user.soja_updated_at) / 3600).floor
    new_soja = current_user.soja + soja_to_add
    if new_soja > 48
      current_user.soja = 48
    else
      current_user.soja = new_soja
    end
    current_user.soja_updated_at = Time.now.at_beginning_of_hour
    current_user.save
  end

  # def user_not_authorized
  #   flash[:error] = I18n.t('controllers.application.user_not_authorized', default: "You can't access this page.")
  #   redirect_to(root_path)
  # end
end
