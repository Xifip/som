class RunsController < ApplicationController
    before_filter :authenticate_user!

    def index
      @runs = Run.all
    end
    
    def new
      @run = Run.new
    end

    def create
      @run = Run.new(title: params[:run][:title],
                     s3folder: params[:run][:s3folder])                                             
        # note update_attributes Updates this resource with all the attributes 
        # from the passed-in Hash and requests that the record be saved.
      
      @run.path = "https://s3-us-west-2.amazonaws.com/somrst/" + @run.s3folder + "/"
      if @run.save
        flash[:success] = "Run created!"
        redirect_to run_results_path(@run)
      else
        render :new 
      end
    end

    def destroy
      @run = Run.find(params[:id])
      @run.destroy

    end
end
