Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root                'pages#home'
  get    'about'   => 'pages#about'
  get    'help'    => 'pages#help'
  get    'contact' => 'pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :account_activations, only: :edit
end
