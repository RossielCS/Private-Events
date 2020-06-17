class UsersController < ApplicationController
  def show
    @user = current_user
    @prev_events = current_user.attended_events.past
    @upcoming_events = current_user.attended_events.upcoming    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:notice] = 'User successfully created.'
      redirect_to @user
    else
      flash[:notice] = 'There was an error while creating the user.'
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
