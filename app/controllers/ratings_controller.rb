class RatingsController < ApplicationController

  def like
    @post = Post.find(params[:post_id])
    @post.ratings.create
    @post.update_attributes(:likes => (@post.likes + 1))
    redirect_to posts_path
  end

  def dislike
    @post = Post.find(params[:post_id])
    @post.ratings.create
    @post.update_attributes(:dislikes => (@post.dislikes + 1))
    redirect_to posts_path
  end


end
