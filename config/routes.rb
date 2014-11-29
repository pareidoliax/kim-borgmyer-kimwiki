Kimwiki::Application.routes.draw do  
  devise_for :users

  resources :charges, only: [:new, :create]
  resources :collaborations, only: [:create]
  resources :users, only: [:update]

  resources :wikis do
    resources :collaborations, only: [:index, :update], controller: 'wikis/collaborations'
  end

  get :collaborators, to: 'wikis#collaborators'

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
