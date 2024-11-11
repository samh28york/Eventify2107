class GuestsController < ApplicationController
    before_action :authenticate_user!

    def index
      @events = Event.joins(:guest_list).where(guest_lists: { guest_id: current_user.id })
    end

    def update_attendance
      guest_list = GuestList.find_by(guest_id: current_user.id, event_id: params[:event_id])
      if guest_list && guest_list.update(rsvp_status: params[:rsvp_status])
        redirect_to guest_home_path, notice: "Attendance updated successfully."
      else
        redirect_to guest_home_path, alert: "Failed to update attendance."
      end
    end

    def destroy
      guest_list = GuestList.find_by(guest_id: params[:id], event_id: params[:event_id])
      if guest_list
        guest_list.destroy
        redirect_to guests_path, notice: "Event removed from your dashboard."
      else
        redirect_to guests_path, alert: "Failed to remove event."
      end
    end
end
