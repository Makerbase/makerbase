class CodereviewsController < ApplicationController

  def index
    @codereviews = Codereview.all
  end

  def new
    @codereview = Codereview.new
  end

  def create
    @codereview = Codereview.create(codereview_params)
    redirect_to codereviews_path
  end

  def codereview_params
    params.require(:codereview).permit(:title, :url)
  end
end
