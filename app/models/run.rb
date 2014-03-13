class Run < ActiveRecord::Base
  attr_accessible :title, :path

  has_many :results, :dependent => :destroy

  after_create :create_results

  def getS3Objs
    if Rails.env.development?
      s3 = AWS::S3.new(
        :access_key_id => S3_CONFIG[::Rails.env]["access_key_id"],
        :secret_access_key => S3_CONFIG[::Rails.env]["secret_access_key"]      
      )
    elsif Rails.env.production?
      s3 = AWS::S3.new(
        :access_key_id     => ENV['S3_KEY'],
        :secret_access_key => ENV['S3_SECRET']     
      )
    end
    objs = []  
    s3.buckets['somrst'].objects.with_prefix('run' + self.id.to_s + '/').each do |object|
      objs.push object.key
    end


    return objs
  end

  private

  def create_results
    Factor.all.each do |factor|
      self.results.create(factor_id: factor.id, name: factor.description, url: "https://s3-us-west-2.amazonaws.com/somrst/run" + self.id.to_s + "/" + factor.name + ".png")
    end  
  end
end