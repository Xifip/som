class ResultsController < ApplicationController
    def index
      @results_all = Result.find_all_by_run_id(params[:run_id])
      @results = []
      @s3Objs = Run.find(params[:run_id]).getS3Objs

      @results_all.each do |result|
        @results.push result if @s3Objs.map(&:downcase).include? result.imgS3Path.downcase
      end

      @run = Run.find(params[:run_id])
    end
end
