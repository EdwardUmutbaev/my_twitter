class PostsController < ApplicationController
  def create
    post = current_user.posts.build(params[:post])
    post.save!      
    redirect_to root_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy  
    respond_to do |format|
      format.js 
      format.html       
    end  
  end
end
