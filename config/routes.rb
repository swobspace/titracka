Rails.application.routes.draw do
  resources :workdays
  resources :time_accountings
  resources :lists
  resources :org_units
  resources :tasks
  resources :states
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/pages/index", to: 'pages#index'
  get "/pages/*page", to: 'pages#show', as: :page, format: false

  root to: 'workdays#index'
  mount Wobauth::Engine, at: '/auth'
end
