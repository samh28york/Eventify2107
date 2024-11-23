class GuestsController < ApplicationController
    before_action :authenticate_user!

    def index
      @events = Event.joins(:GuestList).where(guest_lists: { guest_id: current_user.id })
    end

    def create
      @user = User.find_or_create_by(email: params[:email]) do |user|
        user.first_name = params[:first_name]
        user.last_name = params[:last_name]
        user.password = SecureRandom.hex(8)
      end
  
      guest = @event.guests.build(user: @user, role: params[:role] || "guest")
  
      if guest.save
        redirect_to @event, notice: "Guest successfully created."
      else
        redirect_to @event, alert: "Failed to create guest: #{guest.errors.full_messages.join(', ')}"
      end
    end

    def update
      guest = @event.guests.find(params[:id])
  
      if guest.update(guest_params)
        redirect_to @event, notice: "Guest information updated successfully."
      else
        redirect_to @event, alert: "Failed to update guest information: #{guest.errors.full_messages.join(', ')}"
      end
    end

    def destroy
      guest = @event.guests.find(params[:id])
  
      if guest.destroy
        redirect_to @event, notice: "Guest removed successfully."
      else
        redirect_to @event, alert: "Failed to remove guest."
      end
    end

    private

    def set_event
      @event = Event.find(params[:event_id])
    end

    def guest_params
      params.require(:guest).permit(:role, :rsvp_status, :party_size)
    end
end
