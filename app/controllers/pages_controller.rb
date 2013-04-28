 class PagesController < ApplicationController
  require 'debugger'
  layout 'admin'
  before_filter :find_subject

	def index
		list
		render("list")
	end

	def list
		@pages = Page.sorted.where(:subject_id => @subject.id)
	 
	end
	
	def show
		@page = Page.find(params[:id])	
	end
	
	def new
	  # debugger
	  @page = Page.new(:subject_id => @subject.id)
    @page_count = @subject.pages.size + 1
    @subjects = Subject.order('position ASC')
  end
	
	def create
    new_position = params[:page].delete(:position)
		@page = Page.new(params[:page])
		
		if @page.save
      @page.move_to_position(new_position)
			flash[:notice] = "Successfully created"
		  redirect_to(:action => "show",:id => @page.id, :subject_id => @page.subject_id)		  
		else
      @page_count = @subject.pages.size + 1
		  render("new")
	  end
	  
	end
	
	def edit
	  @page = Page.find(params[:id])
    @page_count = @subject.pages.size
  end
  
  def update
  	@page = Page.find(params[:id])
  	
    new_position = params[:page].delete(:position)
  	if @page.update_attributes(params[:page])
      @page.move_to_position(new_position)
  		flash[:notice] = "Updated successfully"
  		redirect_to(:action => "show",:id => @page.id,:subject_id => @page.subject_id)  		
  	else
      @page_count = @subject.pages.size
  		render('edit')
  	end
  end
  
  def delete
  	@page = Page.find(params[:id])
  end
  
  def destroy  
  	page = Page.find(params[:id])
    page.move_to_position(nil)
    page.destroy
  	
  	flash[:notice] = "Page destroyed"
  	redirect_to(:action => "list", :subject_id => @subject.id) 	
  	
  end
  
  private
  
  def find_subject
    # debugger
    if params[:subject_id]
      @subject = Subject.find_by_id(params[:subject_id])
    end
  end

end
