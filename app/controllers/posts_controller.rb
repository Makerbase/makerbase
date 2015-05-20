class PostsController < ApplicationController

  def index
    # if current_user
      @posts = Post.all
    # else
      # redirect_to root_path
    # end
  end

  # def index
  #   @posts = Post.all
  # end

  def new
    if current_user
      @post = Post.new
    else
      redirect_to root_path
    end
  end

  def create
    @post = Post.create(new_params)
    redirect_to posts_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Post deleted'
    redirect_to '/posts'
  end

  def show
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
     @post = Post.find(params[:id])
     @post.update(new_params)
     redirect_to '/posts'
  end

  private

  def new_params
    params.require(:post).permit(:title, :link, :all_tags)
  end
end
