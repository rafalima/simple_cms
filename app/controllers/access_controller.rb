class AccessController < ApplicationController
  
  layout 'admin'
  
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  
  def index
    menu
    render "menu"
  end
  
  def menu
  end

  def login
  end
  
  def attempt_login
    authorized_user = AdminUser.authenticate(params[:username], params[:password])
    
    if authorized_user
      flash[:notice] = "You are now logged in"
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      redirect_to(:action =>'menu')
    else
      flash[:notice] = "Username/password are invalid"
      redirect_to(:action => "login")
    end
    
  end
  
  
  def logout
    flash[:notice] = "Logged out"
    session[:user_id] = nil
    session[:username] = nil
    redirect_to(:action => "login")
    
  end
end
