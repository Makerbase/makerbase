class LikesController < ApplicationController
  include RatingsHelper

  def create
    @post = Post.find(params[:post_id])
    @dislike = Dislike.where(user_id: current_user.id, post_id: @post.id)
    @like = Like.where(user_id: current_user.id, post_id: @post.id)

    if already_disliked?(@post) || not_already_liked?(@post)
      remove_dislike(@dislike)
      add_like_to(@post)
      redirect_to posts_path
    elsif already_liked?(@post)
      remove_like(@like)
      redirect_to posts_path
    else
      add_like_to(@post)
      redirect_to posts_path
    end
  end
end
