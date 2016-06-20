class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash_add("Account created!")
      log_in(@user)
      redirect_to user_url(@user)
    else
      flash_now(@user.errors.full_messages)
      render :new
    end
  end

  def destroy
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user == "no user"
      flash_now("Account not found")
      render :delete
    elsif @user == "no password"
      flash_now("Incorrect password")
      render :delete
    else
      @user.destroy
      flash_add("Account deleted")
      redirect_to new_user_url
    end
  end

  def prepare_to_destroy
    render :delete
  end

  def show
    render :show
  end

  def edit
    render :edit
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash_add("Successfully updated")
      redirect_to user_url(@user)
    else
      flash_now(@user.errors.full_messages)
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
