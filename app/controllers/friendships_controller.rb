class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:friendship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }    
    end
  end
  
  def destroy
    @user = Friendship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }      
    end
  end
end
