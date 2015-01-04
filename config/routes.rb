Rails.application.routes.draw do
  get 'users/new'

  root 'pages#home'
  get  'pages/about', as: 'about'
  get  'pages/help', as: 'help'
  get  'pages/contact', as: 'contact'
end
