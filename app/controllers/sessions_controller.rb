class SessionsController < ApplicationController
    def new_guest
      # Render guest login form
    end

    def new_organizer
      # Render organizer login form
    end

    def create_guest
      guest = Guest.find_by(email: params[:email])
      if guest&.authenticate(params[:password])
        session[:guest_id] = guest.id
        redirect_to guest_home_path, notice: "Logged in successfully."
      else
        flash.now[:alert] = "Invalid email or password"
        render :new_guest
      end
    end

    def create_organizer
      organizer = Organizer.find_by(email: params[:email])
      if organizer&.authenticate(params[:password])
        session[:organizer_id] = organizer.id
        redirect_to events_path, notice: "Logged in successfully."
      else
        flash.now[:alert] = "Invalid email or password"
        render :new_organizer
      end
    end
end
