Kimwiki::Application.routes.draw do
  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
