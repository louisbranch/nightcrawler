class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :create_body_identifiers
  before_filter :load_categories
  
  def create_body_identifiers
    @body_class = params[:controller]
    @body_id = params[:action]
  end
  
  def load_categories
    @categories = Category.all
  end
  
end
