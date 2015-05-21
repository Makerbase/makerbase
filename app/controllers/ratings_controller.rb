class RatingsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post.ratings.create
    redirect_to posts_path
  end
end
