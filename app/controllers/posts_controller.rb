class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(new_params)
    redirect_to posts_path 
  end

  private

  def new_params
    params.require(:post).permit(:title, :link)
  end
end
