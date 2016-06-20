class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params[:username],
      session_params[:password])

    if @user == "no password"
      flash_now("Password incorrect")
      render :new
    elsif @user == "no user"
      flash_now("User not found")
      render :new
    else
      log_in(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    log_out
  end

  private
  def session_params
    params.require(:user).permit(:username, :password)
  end
end
