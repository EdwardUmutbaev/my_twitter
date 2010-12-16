class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to root_url, :notice => 'User was successfully created.'
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])   
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to root_path, :success => 'Profile updated.' 
    else     
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy    
    redirect_to root_path, :success => 'User destroyed.'
  end

  def index
    @users = User.all
  end

  def show

  end
end