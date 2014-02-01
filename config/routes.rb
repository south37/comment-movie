NikoNiko::Application.routes.draw do
  get  'movies' => 'movies#index'
  post 'movies' => 'movies#create'

  post 'comments' => 'comments#create'
  
  root :to => 'welcome#index'
end
