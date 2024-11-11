class GuestListsController < ApplicationController
    before_action :set_event

    def index
      @guests = @event.guests
    end

    def update_attendance
      guest_list = GuestList.find_by(guest_id: params[:id], event_id: @event.id)

      if guest_list && guest_list.update(rsvp_status: params[:attending])
        redirect_to event_guest_lists_path(@event), notice: "Attendance updated successfully."
      else
        redirect_to event_guest_lists_path(@event), alert: "Failed to update attendance."
      end
    end

    def destroy
      guest_list = GuestList.find_by(guest_id: params[:id], event_id: @event.id)

      if guest_list
        guest_list.destroy
        redirect_to event_guest_lists_path(@event), notice: "Guest removed from event."
      else
        redirect_to event_guest_lists_path(@event), alert: "Failed to remove guest."
      end
    end

    private

    def set_event
      @event = Event.find(params[:event_id])
    end
end
