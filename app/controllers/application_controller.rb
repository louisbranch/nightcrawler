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
  
  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      @config ||= if ENV['USER_NAME'] && ENV['USER_PASSWORD']
        username == ENV['USER_NAME'] && password == ENV['USER_PASSWORD']
      else
        username == "" && password == ""
      end
    end
  end
end
