class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @guests = @event.guests
  end


  def create
    @event = Event.new(event_params)
    @event.user = current_user

    @event.start_time = parse_date_and_time(params[:event][:start_date], params[:event][:start_hour], params[:event][:start_minute], params[:event][:start_period])
    @event.end_time = parse_date_and_time(params[:event][:end_date], params[:event][:end_hour], params[:event][:end_minute], params[:event][:end_period])

    if @event.save
      Rails.logger.info "Event created successfully! ID: #{@event.id}"
      # Automatically make the creator an admin guest for this event
      @event.guests.create!(user: current_user, role: "admin", rsvp_status: "accepted")
      redirect_to @event, notice: "Event was successfully created."
    else
      Rails.logger.error "Failed to create event. Errors: #{@event.errors.full_messages.join(", ")}"
      flash.now[:alert] = "Failed to create event: #{@event.errors.full_messages.join(", ")}"
      render :new
    end
  end


  def edit
    @event
  end

  def update
    @event.start_time = parse_date_and_time(params[:event][:start_date], params[:event][:start_hour], params[:event][:start_minute], params[:event][:start_period])
    @event.end_time = parse_date_and_time(params[:event][:end_date], params[:event][:end_hour], params[:event][:end_minute], params[:event][:end_period])

    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @event.destroy!
    redirect_to events_path, notice: "Event was successfully deleted."
  rescue ActiveRecord::RecordNotDestroyed => e
    redirect_to events_path, alert: "Event could not be deleted: " + e.message
  end


  def add_guest
    @event = Event.find(params[:id])
    @user = User.find_or_create_by(email: params[:email]) do |user|
      user.first_name = params[:first_name]
      user.last_name = params[:last_name]
      user.password = SecureRandom.hex(8) # Generates a random password
    end

    guest = @event.guests.find_or_initialize_by(user: @user)
    guest.role ||= "guest"

    if guest.save
      redirect_to @event, notice: "Guest successfully added."
    else
      redirect_to @event, alert: "Failed to add guest: #{guest.errors.full_messages.join(', ')}"
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :start_date, :end_date, :location, :description)
  end

  def parse_date_and_time(date, hour, minute, period)
    time_string = "#{date} #{hour}:#{minute} #{period}"
    Time.zone.parse(time_string)
  end
end
