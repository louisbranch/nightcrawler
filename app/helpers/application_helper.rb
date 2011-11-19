module ApplicationHelper
  def title
    base_title = "Gozando a vida"
    if @title.nil?
      base_title
    else
      "#{base_title} :: #{@title}"
    end
  end
  
  def description
    unless @description.nil?
      @description
    end
  end
end
