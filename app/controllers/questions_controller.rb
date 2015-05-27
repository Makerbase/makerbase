class QuestionsController < ApplicationController
  def new
    @user = current_user
    @question = @user.questions.new
  end
  
  def create
    @user = current_user
    @question = @user.questions.create(post_params)
    redirect_to '/forum'
  end

  def destroy
    @question = Question.find(params[:id])
    if current_user = @question.user
      @question.destroy
      flash[:notice] = 'Question deleted'
      redirect_to '/forum'
    else
      flash[:notice] = 'Not your question'
      redirect_to '/forum'
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    # @answer = @question.answers.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = current_user.questions.create(post_params)
    flash[:notice] = "Question has been edited"
    redirect_to '/forum'
  end

  private
  def post_params
    params.require(:question).permit(:title, :body)
  end

end
