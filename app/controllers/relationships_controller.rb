class RelationshipsController < ApplicationController
    before_action :logged_in_person

    def create
        @person = Person.find(params[:befriended_id])
        current_person.befriend(@person)
        redirect_to @person
        respond_to do |format|
            format.html { redirect_to @person }
            format.js
        end
    end

    def destroy
        @person = Relationship.find(params[:id]).befriended
        current_person.unbefriend(@person)
        redirect_to @person
        respond_to do |format|
            format.html { redirect_to @person }
            format.js
        end
    end
end
