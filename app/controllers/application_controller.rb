class ApplicationController < ActionController::Base
    include Authenticated

    def page_not_found
        redirect_to '/404'
    end
end
