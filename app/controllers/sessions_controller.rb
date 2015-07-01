class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      flash[:notice] = "Hi " + @user.email + ", you're all logged in!"
      session[:user_id] = @user.id
      redirect_to "/"
    else
      flash[:alert] = "Your credentials did not match an existing account.  Try again or create a new account."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:alert] = "Logged out successfully."
    redirect_to "/"
  end
end
