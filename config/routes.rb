Rails.application.routes.draw do
  root to: "pages#home"
  resources :orders
  # get "/orders/:id", to: "orders#search", as: "search"
end
