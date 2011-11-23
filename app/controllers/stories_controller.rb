# encoding: UTF-8
class StoriesController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]
  
  def index
    @title = 'Os melhores Contos Eróticos'
    @description = "Leia as histórias mais picantes sobre #{@categories.map(&:name).join(", ")}"
    @stories = Story.page(params[:pagina]).order('created_at DESC').per_page(10)
  end
  
  def show
    @story = Story.find(params[:id])
    @title = "#{@story.title} / #{@story.categories.map(&:name).join(" / ") unless @story.categories.empty?}"
    @description = @story.content.truncate(120).gsub(/\n\n/, ' ')
  end
  
  def edit
    @story = Story.find(params[:id])
  end
  
  def update
    @story = Story.find(params[:id])
    @story.update_attributes(params[:story])
    if @story.save
      @story.assign_tags(params[:category_ids])
      flash[:notice] = "Conto atualizado!"
      redirect_to story_path(@story)
    else
      flash[:notice] = 'Ocorreu um erro ao atualizar o conto!'
      redirect_to edit_story_path(@story)
    end
  end
  
  def destroy
    @story = Story.find(params[:id])
    if @story.destroy
      flash[:notice] = 'Conto excluído!'
    else
      flash[:alert] = 'Ocorreu um erro ao excluir o conto!'
    end
    redirect_to stories_path
  end
end
