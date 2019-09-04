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
