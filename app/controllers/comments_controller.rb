class CommentsController < ApplicationController
  def new
    load_post
    @user = current_user
    @comment = @user.comments.new
  end

  def create
    load_post
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to post_path(@post)
  end


  def destroy
    load_comment
    if current_user == @comment.user
      @comment.destroy
      redirect_to post_path(params[:post_id])
    else
      flash[:notice] = 'Cannot delete a comment you haven\'t created'
      redirect_to post_path(params[:post_id])
    end
  end

  def show
  end

  def edit
    @comment = Comment.find(params[:id])
    unless current_user.id == @comment.user_id
      flash[:notice] = 'Cannot edit a comment you haven\'t created'
      redirect_to post_path(@comment.post_id)
    end
  end

  def update
    load_comment
    @comment.update(comment_params)
    redirect_to post_path(@comment.post_id)
  end


  private
  def comment_params
    params.require(:comment).permit(:comments, :post_id)
  end

  def load_post
    @post = Post.find(params[:post_id])
  end

  def load_comment
    @comment = Comment.find(params[:id]) 
  end
end
