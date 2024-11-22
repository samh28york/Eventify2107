class HomeController < ApplicationController
  before_action :authenticate_user!, only: [ :index ]
  
  def index
    @events = Event.joins(:guests).where(guests: { user_id: current_user.id })
  end
end
