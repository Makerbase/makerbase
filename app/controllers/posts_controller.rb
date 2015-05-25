class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    if current_user
      if params[:tag]
        @posts = Post.tagged_with(params[:tag])
      else
        @posts = Post.all
      end
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
    load_post
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
    load_post
  end

  def edit
    load_post
  end

  def update
     load_post
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

  def load_post
    @post = Post.find(params[:id])
  end
end
