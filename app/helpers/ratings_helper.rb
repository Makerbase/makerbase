module RatingsHelper
   def already_liked?(post)
    post.likes.where(user_id: current_user.id).count >= 1
  end

  def already_disliked?(post)
    post.dislikes.where(user_id: current_user.id).count >= 1
  end

  def not_already_disliked?(post)
    !already_disliked?(post)
  end

  def not_already_liked?(post)
    !already_liked?(post)
  end

  def remove_like(like)
    Like.destroy(like) unless like.blank?
  end

  def remove_dislike(dislike)
    Dislike.destroy(dislike) unless dislike.blank?
  end

  def add_dislike_to(post)
    Dislike.create(post_id: post.id, user_id: current_user.id)
  end
  def add_like_to(post)
    Like.create(post_id: post.id, user_id: current_user.id)
  end
end
