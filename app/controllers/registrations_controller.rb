class RegistrationsController < ApplicationController
    def new_guest
      @guest = Guest.new
    end

    def new_organizer
      @organizer = Organizer.new
    end

    def create_guest
      @guest = Guest.new(guest_params)
      if @guest.save
        session[:guest_id] = @guest.id
        redirect_to guest_home_path, notice: "Guest account created successfully."
      else
        render :new_guest
      end
    end

    def create_organizer
      @organizer = Organizer.new(organizer_params)
      if @organizer.save
        session[:organizer_id] = @organizer.id
        redirect_to organizer_home_path, notice: "Organizer account created successfully."
      else
        render :new_organizer
      end
    end

    private

    def guest_params
      params.require(:guest).permit(:email, :password, :password_confirmation)
    end

    def organizer_params
      params.require(:organizer).permit(:email, :password, :password_confirmation)
    end
end
