# -*- coding: utf-8 -*-
class AnswersController < ApplicationController
  def index
    @answers_not_answered = session[:user].answers.not_answered
    @answers_not_corrected = session[:user].answers.not_corrected
    @answers_completed = session[:user].answers.completed
    @questions_not_corrected = session[:user].questions.not_corrected
    @questions_completed = session[:user].questions.completed
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
    @peer_review = PeerReview.new
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

  def peer_review
    logger.debug "test"
    logger.debug params
    @answer = Answer.find(params[:answer][:id])
    @peer_review = PeerReview.new
    @peer_review.answer = @answer
    @peer_review.user = @answer.question.user
    @peer_review.question_body = params[:question_body]
    unless @peer_review.save
      flash[:error] = "保存に失敗しました"
      logger.debug @answer.errors.full_messages
      render :action => :show_correction
      return
    end
    redirect_to :action => :index
    return
  end

end
