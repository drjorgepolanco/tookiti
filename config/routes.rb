Rails.application.routes.draw do
  root                'pages#home'
  get    'about'   => 'pages#about'
  get    'help'    => 'pages#help'
  get    'contact' => 'pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers #, :posts, :contests
    end
  end
  resources :account_activations, only: :edit
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :posts
  resources :contests
  resources :relationships,       only: [:create, :destroy]
end
