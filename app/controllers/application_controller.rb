class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :login_check
  before_filter :load_user
  private
  def login_check
    unless session[:user]
      redirect_to :controller => :account, :action => :login
      return false
    end
  end

  def load_user
    @user = User.find_by_id(session[:user][:id]) if session[:user]
  end
end
