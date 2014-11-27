Kimwiki::Application.routes.draw do  
  devise_for :users

  resources :charges, only: [:new, :create]
  resources :collaborations, only: [:new, :create]
  resources :users, only: [:update]
  resources :wikis do
    resources :collaborations, only: [:index], controller: 'wikis/collaborations'
  end
  
  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
