# -*- coding: utf-8 -*-
class AnswersController < ApplicationController
  def index
    @answers_not_answered = session[:user].answers.not_answered
    @answers_not_corrected = session[:user].answers.not_corrected
    @answers_completed = session[:user].answers.completed
    @question_not_corrected = session[:user].questions.not_corrected
  end

  def answer
    @answer = Answer.find(params[:id])
  end
  
  def post_answer
    @answer = Answer.find(params[:answer][:id])
    @answer.body = params[:answer][:body]
    unless @answer.save
      flash[:error] = "保存に失敗しました"
      logger.debug @answer.errors.full_messages
      render :action => :answer
      return
    end
    redirect_to :action => :index
    return
  end
  
  def show_correction
    @answer = Answer.find(params[:id])
  end

  def show_answer
    @answer = Answer.find(params[:id])
  end

  def correction
    @answer = Answer.find(params[:id])
  end

  def post_correction
    @answer = Answer.find(params[:answer][:id])
    @answer.correction = params[:answer][:correction]
    unless @answer.save
      flash[:error] = "保存に失敗しました"
      logger.debug @answer.errors.full_messages
      render :action => :correction
      return
    end
    redirect_to :action => :index
    return
  end

end
