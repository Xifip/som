require 'net/http'

class Result < ActiveRecord::Base
   attr_accessible :name, :url, :run_id, :factor_id

   belongs_to :run
   belongs_to :factor

  def imgS3Path
    s3Path = self.url.split('/')[-2] + '/' + self.url.split('/')[-1]
    s3Path
  end


end
