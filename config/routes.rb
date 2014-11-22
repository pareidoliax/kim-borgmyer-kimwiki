Kimwiki::Application.routes.draw do
  resources :wikis
  
  devise_for :users
  resources :users, only: [:update]
  resources :charges, only: [:new, :create]
  
  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
