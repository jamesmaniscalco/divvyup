class ApplicationController < ActionController::Base
  include SharedMethods

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |g| g.permit(:group_name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |g| g.permit(:login, :password, :remember_me) }
  end

end
