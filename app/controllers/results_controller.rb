class ResultsController < ApplicationController
    def index
      @results = Result.find_all_by_run_id(params[:run_id])
      @run = Run.find(params[:run_id])
    end
end
