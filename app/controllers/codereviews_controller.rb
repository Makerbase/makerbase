class CodereviewsController < ApplicationController

  def index
    if current_user
      @codereviews = Codereview.all
    else
      redirect_to root_path
    end
  end

  def new
    if current_user
      @codereview = Codereview.new
    else
      flash[:notice] = 'Duplicate Link'
      redirect_to root_path
    end
  end

  def create
    @codereview = Codereview.new(codereview_params)
    @codereview.user_id = current_user.id
    if @codereview.save
      redirect_to codereviews_path
    else
      flash[:notice] = 'Duplicate Link'
      render 'new'
    end
  end

  def destroy
    @codereview = Codereview.find(params[:id])
    if current_user == @codereview.user
      @codereview.destroy
      flash[:notice] = 'Request deleted'
      redirect_to codereviews_path
    else
      flash[:notice] = 'Cannot delete'
      redirect_to codereviews_path
    end
  end

  def edit
    @codereview = Codereview.find(params[:id])
  end

  def update
     @codereview = Codereview.find(params[:id])
     if current_user == @codereview.user
       @codereview.update(codereview_params)
       redirect_to codereviews_path
     else
      flash[:notice] = 'Cannot edit'
      redirect_to codereviews_path
     end
  end

  def codereview_params
    params.require(:codereview).permit(:title, :url, :user_id)
  end
end
