# encoding: UTF-8
class StoriesController < ApplicationController
  
  def index
    @title = 'Os melhores Contos Eróticos'
    @description = "Leia as histórias mais picantes sobre #{@categories.map(&:name).join(", ")}"
    @stories = Story.page(params[:pagina]).per_page(10)
  end
  
  def show
    @story = Story.find(params[:id])
    @title = "#{@story.title} / #{@story.tags.first.category.name}"
    @description = @story.content.truncate(100).gsub(/\n\n/, ' ')
  end
  
end
