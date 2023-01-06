Rails.application.routes.draw do
  root to: 'orders#new'
  resources :orders, only: %i[show new create]
end
