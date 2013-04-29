class AdminUsersController < ApplicationController
  
  layout 'admin'
  
  def index
    list
    render('list')
  end

  def list
    @admin_users = AdminUser.sorted
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(params[:admin_user])
    
    if @admin_user.save
      flash[:notice] = "Admin User created"
      redirect_to(:action => "list")
    else
      render('new')
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    @admin_user = AdminUser.find(params[:id])
    
    if @admin_user.update_attributes(params[:admin_user])
      flash[:notice] = "Admin User updated"
      redirect_to(:action => 'list')
     else
      render('edit')
    end
  end

  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    AdminUser.find(params[:id]).destroy
    
    flash[:notice] = "Admin User destroyed"
    redirect_to(:action => 'list')
  end
  
end
