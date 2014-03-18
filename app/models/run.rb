class Run < ActiveRecord::Base
  attr_accessible :title, :path, :s3folder

  has_many :results, :dependent => :destroy

  after_create :create_results

  def getS3Objs
    if Rails.env.development?
      s3 = AWS::S3.new(
        #:access_key_id => S3_CONFIG[::Rails.env]["access_key_id"],
        #:secret_access_key => S3_CONFIG[::Rails.env]["secret_access_key"] 
        :access_key_id     => ENV['S3_KEY'],
        :secret_access_key => ENV['S3_SECRET']               
      )
    elsif Rails.env.production?
      s3 = AWS::S3.new(
        :access_key_id     => ENV['S3_KEY'],
        :secret_access_key => ENV['S3_SECRET']     
      )
    end
    objs = []
    #debugger  
    s3.buckets['somrst'].objects.with_prefix(self.s3folder.to_s + '/').each do |object|
      objs.push object.key
    end


    return objs
  end

  private

  def create_results
    Factor.all.each do |factor|
      self.results.create(factor_id: factor.id, name: factor.description, url: self.path.to_s + factor.name + ".png")
    end  
  end
end