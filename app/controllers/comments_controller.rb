class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end

  def comment_params
    params.require(:comment).permit(:comments, :post_id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user.id == @comment.user_id
      @comment.destroy
      redirect_to post_path(params[:post_id])
    else
      flash[:notice] = 'Cannot delete a comment you haven\'t created'
      redirect_to post_path(params[:post_id])
    end
  end

  def show
    # @comment = Post.find(params[:id])
  end

  def edit
    # @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if current_user.id == @comment.user_id
      @comment.update(comment_params)
      redirect_to post_path(@comment.post_id)
    else
      flash[:notice] = 'Cannot edit a comment you haven\'t created'
      redirect_to post_path(@comment.post_id)
    end
    # @comment.update(new_params)
    # redirect_to edit_comment_path(@comment)
  end

  def new_params
    params.permit(:id, :post_id)
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to post_path(@comment.post_id)
  end
end
