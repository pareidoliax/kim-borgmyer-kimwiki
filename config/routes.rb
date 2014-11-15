Kimwiki::Application.routes.draw do
  devise_for :users
  resources :users, only: [:update]
  
  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
