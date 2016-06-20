class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :slicer

  def slicer(title, description, slice_length=20)
    if description.length > slice_length
      add_on = "..."
    else
      add_on = ""
    end
    "#{title} (#{description.slice(0,slice_length)}#{add_on})"
  end

  def log_in(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def log_out
    current_user.session_token = nil
    session[:session_token] = nil
    redirect_to subs_url
  end

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def flash_now(notices)
    flash.now[:notices] ||= []

    if notices.is_a?(Array)
      notices.each do |notice|
        flash.now[:notices] << notice
      end
    else
      flash.now[:notices] << notices
    end
  end

  def flash_add(notices)
    flash[:notices] ||= []

    if notices.is_a?(Array)
      notices.each do |notice|
        flash[:notices] << notice
      end
    else
      flash[:notices] << notices
    end
  end

  def ensure_logged_in!
    unless current_user
      flash_add("You must be logged in to do this")
      redirect_to new_session_url
    end
  end

  def ensure_moderator(mod_id)
    unless mod_id == current_user.id
      flash_add("You must be the moderator to edit")
      redirect_to :back
    end
  end
end
