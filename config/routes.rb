Nightcrawler::Application.routes.draw do
  resources :categories, :path => :categorias
  resources :stories, :path => 'contos-eroticos'
  resources :sources
  
  root :to => 'stories#index'
end
