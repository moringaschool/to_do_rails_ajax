class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      flash[:notice] = "Welcome! Your account was created."
      redirect_to "/"
    else
      flash[:alert] = "There was an issue creating your account.  Try again."
      redirect_to :back
    end
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
