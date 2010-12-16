class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])

    if user.blank?
      render :action => 'new'
    else      
      self.current_user = user
      redirect_to root_url, :notice => 'successfull logged in'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'successfull log out'
  end
end
