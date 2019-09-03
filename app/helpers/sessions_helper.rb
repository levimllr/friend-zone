module SessionsHelper

    # Log in the given person
    def log_in(person)
        session[:person_id] = person.id 
    end

    # Returns the current logged-in user (if any).
    def current_person
        if session[:person_id]
            @current_person ||= Person.find_by(id: session[:person_id])
        end
    end

    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_person.nil?
    end

    def log_out
        session.delete(:person_id)
        @current_person = nil
    end
end
