Rails.application.routes.draw do
  resources :lists
  resources :org_units
  resources :tasks
  resources :states
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/pages/index", to: 'pages#index'
  get "/pages/*page", to: 'pages#show', as: :page, format: false

  mount Wobauth::Engine, at: '/auth'
end
