Rails.application.routes.draw do
  root to: 'pages#home'
  resources :rains, only: [:index, :show, :create]
end
