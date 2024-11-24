class HomeController < ApplicationController
  before_action :authenticate_user!, only: [ :index ]

  def index
    @organized_events = Event.where(user_id: current_user.id)
    @guest_events = Event.joins(:guests).where("guests.user_id = ? AND events.user_id != ?", current_user.id, current_user.id).distinct
    
  end
end
