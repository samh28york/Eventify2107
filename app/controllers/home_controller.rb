class HomeController < ApplicationController
    def index
    end

    def guest_home
      @events = Event.joins(:guest_list).where(guest_lists: { guest_id: current_user.id })
    end

    def organizer_home
      # Logic for organizer home page
    end
end
