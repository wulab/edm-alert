class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      extra_attributes = [:full_name, :postal_code]
      devise_parameter_sanitizer.permit(:sign_up, keys: extra_attributes)
      devise_parameter_sanitizer.permit(:account_update, keys: extra_attributes)
    end
end
