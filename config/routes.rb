Rails.application.routes.draw do
  # get 'sessions/new'
  # get 'users/new'
  # get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'signup'  => 'users#new'  
  resources :users, only: [:new, :create, :show]

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  root 'sessions#new'
end
