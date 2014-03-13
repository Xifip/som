class Result < ActiveRecord::Base
   attr_accessible :name, :url, :run_id

   belongs_to :run
end
