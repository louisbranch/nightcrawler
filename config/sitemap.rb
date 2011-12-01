SitemapGenerator::Sitemap.default_host = "http://gozandoavida.com"

SitemapGenerator::Sitemap.create do

  # Add '/contos-eroticos'
    add stories_path, :priority => 0.7, :changefreq => 'daily'
    Story.find_each do |story|
     add story_path(story), :lastmod => story.updated_at
    end
  
  # Add '/categorias'
    add categories_path
    Category.find_each do |category|
     add category_path(category)
    end
  
end
