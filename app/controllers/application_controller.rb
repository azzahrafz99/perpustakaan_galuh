class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit :first_name, :last_name, :birthdate, :email,
               :password, :password_confirmation, :current_password
    end
  end
end
