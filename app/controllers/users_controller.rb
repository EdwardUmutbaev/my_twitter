class UsersController < ApplicationController
  before_filter :find_user, :only => [:edit, :update, :show]

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
  end

  def update
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
    if current_user
     @posts = @user.user_posts  
    else
     @posts = @user.all_posts
    end        
    @following = @user.following_list     
    @followers = @user.followers_list
  end

  protected
    def find_user
      @user = User.find(params[:id]) 
    end
end
