class CodereviewsController < ApplicationController

  def index
    # if current_user
    @codereviews = Codereview.all
    # else
    #   redirect_to root_path
    # end
  end

  def new
    @codereview = Codereview.new
  end

  def create
    @codereview = Codereview.new(codereview_params)
    @codereview.user_id = current_user.id
    if @codereview.save
      redirect_to codereviews_path
    else
      render 'new'
    end
  end

  def codereview_params
    params.require(:codereview).permit(:title, :url, :user_id)
  end
end
