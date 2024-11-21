class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
  end

  def user_home
    render layout: false
    @events = Event.joins(:guest_lists).where(guest_lists: { user_id: current_user.id })
  end
end
