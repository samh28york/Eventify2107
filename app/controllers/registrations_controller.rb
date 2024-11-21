class RegistrationsController < ApplicationController
    def new_user
      @user = User.new
    end

    def create_user
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_home_path, notice: "Account created successfully."
      else
        render :new_user
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end

end
