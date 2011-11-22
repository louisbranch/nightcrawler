class CategoriesController < ApplicationController
  
  def show
    @category = Category.find(params[:id])
    @stories = @category.stories.page(params[:pagina]).order('created_at DESC').per_page(10)
    @title = "Os melhores Contos Eróticos de #{@category.name}"
  end
  
end
