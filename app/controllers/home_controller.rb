class HomeController < ApplicationController
  def index
    if signed_in? 
      @posts = current_user.all_posts
      @user = current_user

      @following = @user.following
      @following_count = @following.size

      @followers = @user.followers
      @followers_count = @followers.size
    end
  end
end

