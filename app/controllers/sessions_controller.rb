class SessionsController < ApplicationController
    def new_user
      # Render user login form
    end

    def create_user
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_home_path, notice: "Logged in successfully."
      else
        flash.now[:alert] = "Invalid email or password"
        render :new_user
      end
    end

    def destroy_user
      session[:user_id] = nil 
      redirect_to user_sessions_path, notice: "Logged out successfully!"
    end
end
