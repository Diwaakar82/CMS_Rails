class ApplicationController < ActionController::Base
    include Authenticated

    before_action :configure_permitted_parameters, if: :devise_controller?

    def page_not_found
        redirect_to '/404'
    end
protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
end
