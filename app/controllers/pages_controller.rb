 class PagesController < ApplicationController
  require 'debugger'
  layout 'admin'
  before_filter :find_subject

	def index
		list
		render("list")
	end

	def list
		@pages = Page.order("pages.position ASC").where(:subject_id => @subject.id)
	 
	end
	
	def show
		@page = Page.find(params[:id])	
	end
	
	def new
	  # debugger
	  @page = Page.new(:subject_id => @subject.id)
    @page_count = @subject.pages.size + 1
  end
	
	def create
		@page = Page.new(params[:page])
		
		if @page.save
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
  	
  	if @page.update_attributes(params[:page])
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
  	Page.find(params[:id]).destroy
  	
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
