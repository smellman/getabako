# -*- coding: utf-8 -*-
class AccountController < ApplicationController
  skip_before_filter :login_check
  def login

    if request.request_method_symbol == :post
      if params[:login].nil?
        flash[:error] = "ユーザ名、パスワードを入力してください"
        return
      end
      if params[:login][:name].blank?
        flash[:error] = "ユーザ名を入力してください"
        return
      end
      if params[:login][:password].blank?
        flash[:error] = "パスワードを入力してください"
        return
      end
      user = User.find(:first,
                       :conditions => ["name = :name", {:name => params[:login][:name]}]).try(:authenticate, params[:login][:password])
      unless user
        flash[:error] = "ログインに失敗しました、再度試してください"
        return
      end
      session[:user] = user
      redirect_to :controller => :home, :action => :index
      return
    end
  end

  def logout
    session[:user] = nil
    reset_session
    redirect_to :action => :login
  end
end
