class DemoController < ApplicationController
  
  layout 'admin'
  
  def index	
	 @id = params[:id].to_i
	 @page = params[:page].to_i
	 render('index')
  end
  
  def hello
	 #redirect_to(:action => 'index')	
	 @array = [1,2,3,4]
  end
  
  def other_hello
	 render(:text => 'something')
  end
	
	def javascript		
	end
	
	def text_helpers
		
	end
  
  
end
