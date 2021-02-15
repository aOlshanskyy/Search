class PagesController < ApplicationController
  def index
  	@languages = Language.all
  end


  def search  
	if params[:search].blank?  
	  	redirect_to root_path, notice: "Not a valid combination :("
	    # redirect_to(root_path, alert: "Empty field!") and return  
	else  
	    parameter = "%#{params[:search]}%"
	    parameters = params[:search].split(' ')

		#I'm checking to see if one or more words have been entered
	    if parameters.length === 1 
	    	if params[:search].first(1) === "-"
	    		@results = Language.where.not('name ILIKE :search OR typical ILIKE :search OR designed ILIKE :search', search: parameter.from(2))
	    		# @results = Language.where('name NOT IN :search AND typical NOT LIKE :search AND designed NOT LIKE :search', search: parameter.remove!(" "))
	    	else
	    		@results = Language.where('name ILIKE :search OR typical ILIKE :search OR designed ILIKE :search', search: parameter)
	    		
	    	end
	    	
	    else
	    	#If a few then I break them into an array and go through the cycle as many times as the entered words and each time I leave only those 
	    	#cases when each word is found no matter at what position
	    	count = parameters.length
	    	@results = Language.all
	    	for i in 0..count
	    		if parameters[i].to_s.first(1) === "-"
		    		@results = @results.where.not('name ILIKE :search OR typical ILIKE :search OR designed ILIKE :search', search: "%#{parameters[i].from(2)}%")
		    	else
		    		@results = @results.where('name ILIKE :search OR typical ILIKE :search OR designed ILIKE :search', search: "%#{parameters[i]}%")
		    	end
	    	end	
	    end
    end  
  end
end
