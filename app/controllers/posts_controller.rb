class PostsController < ApplicationController

  def index
    if current_user
      @posts = Post.all
    else
      redirect_to root_path
    end
  end

  # def index
  #   @posts = Post.all
  # end

  def new
    @post = Post.new
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

  # def edit
  #   @post = Post.find(new_params)
  # end

  # def update
  #    @post = Post.find(new_params)
  #    @post.update(post_params)
  #    redirect_to '/posts'
  # end

  private

  def new_params
    params.require(:post).permit(:title, :link, :all_tags)
  end
end
