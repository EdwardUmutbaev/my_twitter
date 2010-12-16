class HomeController < ApplicationController
  def index
    if signed_in? 
      @posts = current_user.all_posts
    end
  end
end
