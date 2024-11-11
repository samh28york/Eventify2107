class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user

  def current_user
    @current_user ||= Guest.find(session[:guest_id]) if session[:guest_id]
  end

  def authenticate_user!
    redirect_to new_guest_session_path unless current_user
  end
end
