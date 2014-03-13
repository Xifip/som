class Factor < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :results, :dependent => :destroy
end
