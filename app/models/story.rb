class Story < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged
  before_create :fake_likes
  before_save :capitalize_data
  
  belongs_to :source
  belongs_to :author
  has_many :tags, :as => :taggable, :dependent => :destroy
  has_many :categories, :through => :tags
  
  validates :title,  :presence => true
  validates :source_id,  :presence => true
  validates :content,  :presence => true
  
  def create_by_fetch(hash)
    self.title = hash[:title]
    self.source_id = hash[:source_id]
    self.original_id = hash[:original_id]
    self.content = hash[:content]
    create_category(hash[:category]) unless hash[:category].blank?
    create_author(hash[:email],hash[:author]) unless hash[:email].blank?
    self.save!
  end
  
  def assign_tags(new_categories)
    new_categories ||= []
    new_categories = new_categories.map(&:to_i)
    current_categories = self.categories.map(&:id)
    unless current_categories == new_categories
      excluded_categories = current_categories - new_categories
      excluded_categories.each do |excluded|
        self.tags.find_by_category_id(excluded).destroy
      end
      new_categories.each do |neo|
        cat = Category.find(neo)
        unless self.categories.include?(cat)
          self.tags.create(:category => cat)
        end
      end
    end
  end
   
  protected
  
  def create_category(category)
    tag = self.tags.build
    tag.category = Category.find_or_create_by_name(category)
  end
  
  def create_author(email,name)
   author = Author.find_or_create_by_email(email)
   unless name.blank?
     author.name = name
     author.save!
   end
   self.author_id = author.id
  end
  
  def fake_likes
    self.likes = rand(0-501)
  end
  
  def capitalize_data
    self.title.capitalize!
    self.content.capitalize!
  end
  
end
