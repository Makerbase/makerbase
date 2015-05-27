class ForumsController < ApplicationController
  def index
    @questions = Question.all
  end
end
