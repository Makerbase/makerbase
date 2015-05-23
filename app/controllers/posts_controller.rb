class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    if current_user
      @posts = Post.all
    else
      redirect_to root_path
    end
  end

  def new
    if current_user
      @post = Post.new
    else
      redirect_to root_path
    end
  end

  def create
    @post = Post.new(new_params)
    @post.user_id = current_user.id
    @post.author = current_user.name # should change this to some kind of username
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user.id == @post.user_id
      @post.destroy
      flash[:notice] = 'Post deleted'
      redirect_to posts_path
    else
      flash[:notice] = 'Cannot delete a post you haven\'t created'
      redirect_to posts_path
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
     @post = Post.find(params[:id])
     if current_user.id == @post.user_id
       @post.update(new_params)
       redirect_to posts_path
     else
      flash[:notice] = 'Cannot edit a post you haven\'t created'
      redirect_to posts_path
     end
  end

  private

  def new_params
    params.require(:post).permit(:title, :link, :all_tags)
  end
end
