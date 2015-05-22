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
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

  def show
  end


  # def destroy
  #   @post = Post.find(params[:id])
  #   if @post.comments.create(comment_params)
  #     @comment.destroy
  #     flash[:notice] = 'Comment deleted'
  #     redirect_to post_path(@post)
  #   else
  #     flash[:notice] = 'Cannot delete a comment you haven\'t created'
  #     redirect_to post_path(@post)
  #   end
  # end

end
