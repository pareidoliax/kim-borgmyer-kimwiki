Kimwiki::Application.routes.draw do
  resources :wikis
  
  devise_for :users
  resources :users, only: [:update]
  
  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
