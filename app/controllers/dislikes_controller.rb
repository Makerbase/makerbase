class DislikesController < ApplicationController
  include RatingsHelper

  def create
    @post = Post.find(params[:post_id])
    @dislike = Dislike.where(user_id: current_user.id, post_id: @post.id)
    @like = Like.where(user_id: current_user.id, post_id: @post.id)

    if already_liked?(@post) || not_already_disliked?(@post)
      remove_like(@like)
      add_dislike_to(@post)
      redirect_to posts_path
    elsif already_disliked?(@post)
      remove_dislike(@dislike)
      redirect_to posts_path
    else
      add_dislike_to(@post)
      redirect_to posts_path
    end
  end

end
