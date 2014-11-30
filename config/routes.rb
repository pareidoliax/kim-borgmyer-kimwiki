Kimwiki::Application.routes.draw do  
  devise_for :users

  resources :charges, only: [:new, :create]
  resources :users, only: [:update]

  resources :wikis
  get :collaborators, to: 'wikis#collaborators'

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
