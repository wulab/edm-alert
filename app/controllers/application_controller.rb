class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def route_not_found
    if current_user
      not_found
    else
      redirect_to new_user_session_path
    end
  end

  def not_found
    render_404
  end

  def render_404
    respond_to do |format|
      format.html do
        render file: Rails.root.join("public", "404"), layout: false, status: "404"
      end
      format.any { head :not_found }
    end
  end

  protected
    def configure_permitted_parameters
      extra_attributes = [:full_name, :postal_code]
      devise_parameter_sanitizer.permit(:sign_up, keys: extra_attributes)
      devise_parameter_sanitizer.permit(:account_update, keys: extra_attributes)
    end
end
