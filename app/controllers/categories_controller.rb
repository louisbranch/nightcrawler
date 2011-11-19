class CategoriesController < ApplicationController
  
  def show
    @category = Category.find(params[:id])
    @stories = @category.stories.page(params[:pagina]).per_page(10)
  end
  
end
