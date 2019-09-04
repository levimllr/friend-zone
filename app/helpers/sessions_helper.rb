module SessionsHelper

    # Log in the given person
    def log_in(person)
        session[:person_id] = person.id 
    end

    # Remembers a user in a persistent session
    def remember(person)
        person.remember
        cookies.permanent.signed[:person_id] = person.id
        cookies.permanent[:remember_token] = person.remember_token
    end

    # Forgets a persistent session
    def forget(person)
        person.forget
        cookies.delete(:person_id)
        cookies.delete(:remember_token)
    end

    # Retursn true if the given person is the current person
    def current_person?(person)
        person == current_person
    end

    # Returns the current logged-in user (if any).
    def current_person
        if (person_id = session[:person_id])
            @current_person ||= Person.find_by(id: person_id)
        elsif (person_id = cookies.signed[:person_id])
            person = Person.find_by(id: person_id)
            if person && person.authenticated?(cookies[:remember_token])
                log_in person
                @current_person = person
            end
        end
    end

    # Redirects to stored location (or to the default)
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    # Stores the URL trying to be accessed
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end

    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_person.nil?
    end

    # Logs out the current user
    def log_out
        forget(current_person)
        session.delete(:person_id)
        @current_person = nil
    end
end
