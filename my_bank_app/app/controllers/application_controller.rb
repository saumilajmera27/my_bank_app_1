class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    home_page_path
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name contact_no])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name contact_no])
  end
  
end
