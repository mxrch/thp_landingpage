class ApplicationController < ActionController::Base
    add_flash_types :danger, :info, :warning, :success, :primary

    before_action :sanitize_devise_params, if: :devise_controller?
  
    def sanitize_devise_params
      devise_parameter_sanitizer.permit(:sign_up, keys:[:firstname, :lastname])
    end
end
