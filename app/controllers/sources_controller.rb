class SourcesController < ApplicationController
  before_filter :authenticate
  
  def edit
    @source = Source.find(params[:id])    
  end
  
  def update
    @source = Source.find(params[:id])
    @source.update_attributes(params[:source])
    if @source.save
      flash[:notice] = 'Fonte atualizada!'
      redirect_to root_path
    else
      flash[:alert] = 'Erro ao atualizar fonte!'
      redirect_to edit_source_path(@source)
    end
  end
  
end
