class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :signed_in?, :current_user, :current_user?

  def signed_in?
    !current_user.nil?
  end

  def current_user
    return nil if session[:user_id].blank?
    @current_user ||= User.where(:id => session[:user_id]).first
  end

  def current_user=(user)
    if user.blank?
      @current_user = nil
      session[:user_id] = nil
    else
      session[:user_id] = user.id
      @current_user = user
    end
  end

  def current_user?(user)
    user == current_user
  end
end
