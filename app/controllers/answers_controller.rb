# -*- coding: utf-8 -*-
class AnswersController < ApplicationController
  def index
    @answers_not_answered = session[:user].answers.not_answered
    @answers_not_corrected = session[:user].answers.not_corrected
    @answers_completed = session[:user].answers.completed
  end

  def answer
    @answer = Answer.find(params[:id])
  end
  
  def post_answer
    @answer = Answer.find(params[:id])
    @answer.body = params[:body]
    unless @answer.save
      flash[:error] = "保存に失敗しました"
      render :action => :answer
      return
    end
    redirect_to :action => :index
    return
  end
  
end
