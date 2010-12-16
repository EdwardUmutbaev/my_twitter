class PostsController < ApplicationController
  def create
    post = current_user.posts.build(params[:post])
    post.save!      
    redirect_to root_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy   
    redirect_to :back, :success => 'Post deleted!'
  end
end
