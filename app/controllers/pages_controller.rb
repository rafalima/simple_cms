class PagesController < ApplicationController

	def index
		list
		render("list")
	end

	def list
		@pages = Page.order("pages.position ASC")
	end
	
	def show
		@page = Page.find(params[:id])
	end
	
	def new
	  @page = Page.new
  end
	
	def create
		@page = Page.new(params[:page])
		
		if @page.save
		  redirect_to(:action => "show",:id => @page.id)
		else
		  render("new")
	  end
	  
	end

end
