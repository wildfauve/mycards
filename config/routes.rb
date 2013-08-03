Mycards::Application.routes.draw do

  root :to => "home#index"

  resources :cards do
    resources :pictures
    collection do 
      get "counters"
    end
  end
  
  resources :tags do
    collection do
      get "tag_cloud"
      get "query"
    end
  end

  resources :customers do
    collection do
      get "query"
      post "filter"
    end
  end

  resources :counters
  
  resources :searches
  
  resources :charts


end
