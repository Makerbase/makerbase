class AnswersController < ApplicationController
  def create
    @answer = current_user.answers.new(post_params)
    @answer.question_id = params[:question_id]
    @answer.save
    redirect_to question_path(params[:question_id])
  end

  def edit
    @answer = Answer.find(params[:id])
    redirect_to question_path(@answer.question_id)
  end
  
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to question_path(@answer.question_id)
  end


  private
  def post_params
    params.require(:answer).permit(:body)
  end

end
