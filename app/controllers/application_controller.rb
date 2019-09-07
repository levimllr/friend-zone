class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    # include the SessionsHelper module in all controllers!
    include SessionsHelper

    def hello
        render html: "hello, world!"
    end

    private

    # Confirms a logged-in person
    def logged_in_person
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end
end
