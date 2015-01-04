Rails.application.routes.draw do
  root 'pages#home'
  get  'pages/about'
  get  'pages/help'
  get  'pages/contact'
end
