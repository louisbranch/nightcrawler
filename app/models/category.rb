class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged
  has_many :tags, :dependent => :destroy
  has_many :stories, :through => :tags, :source => :taggable, :source_type => 'Story'
  
  default_scope order(:name)
  
end
