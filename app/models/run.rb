class Run < ActiveRecord::Base
  attr_accessible :title, :path

  has_many :results, :dependent => :destroy

  after_create :get_results

  private

  def get_results
    files = Dir.glob(self.path)
    #files = Dir.glob("C:/R_Workspace/dozer/plots/som/results/**/*")
    files.each do |file|
      name = file.split('/').last.split('.png')[0]
      url = "https://s3-us-west-2.amazonaws.com/somrst/run" + self.id.to_s + "/" + name + ".png"
      self.results.create(name: name, url: url)
    end
  end
end
