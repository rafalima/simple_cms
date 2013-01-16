class SectionsController < ApplicationController

	def index
		list
		render("list")
	end

	def list
		@sections = Section.order("sections.position ASC")	
	end
	
	def show
		@section = Section.find(params[:id])
	end
	
	def new
		@section = Section.new
	end
	
	def create
	  @section = Section.new(params[:section])
	  
	  if @section.save
	    redirect_to(:action => 'show', :id => @section.id)
	  else
	    render('new')
    end
    
  end
  
  

end
