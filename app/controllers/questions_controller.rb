# -*- coding: utf-8 -*-
class QuestionsController < ApplicationController
  def index
    @questions = Question.where(:user_id => session[:user].id)
  end

  def new
    @question = Question.new(:user => session[:user])
    @subjects = Subject.all.map{|i| [i.name, i.id]}
  end

  def create
    subject = Subject.where(:id => params[:question][:subject]).first
    params[:question].delete(:subject)
    @question = Question.new(params[:question])
    @question.subject = subject
    @question.user = session[:user]
    unless @question.valid?
      flash[:error] = @question.errors.full_messages
      render :action => :new
      return
    end
    unless @question.save
      render :action => :new
      return
    end
    @question.create_answers
    flash[:notice] = "質問を作成しました"
    redirect_to :action => :index
  end
end
