class Source < ActiveRecord::Base
  has_many :stories, :dependent => :destroy
  
  validates :title,  :presence => true
  validates :type_id,  :presence => true
  validates :url,  :presence => true
  validates :parse_url,  :presence => true
end
