class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  before_filter :confirm_logged_in
  
  
  protected
  
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => "access", :action => "login")
      return false #halts the before filter
    else
      return true
    end
  end
  
end
