Rails.application.routes.draw do
  get 'home/index'
  get 'home', to: 'home#index'
  get ':date', to: 'workdays#by_date', as: 'by_date', constraints: {date: /2\d\d\d-\d\d-\d\d/ }
  get 'workdays/:date', to: 'workdays#by_date', constraints: {date: /2\d\d\d-\d\d-\d\d/ }
  resources :workdays do
    member do
      get 'by_date'
    end
    resources :time_accountings, module: :workdays
  end
  resources :time_accountings
  resources :lists do
    resources :tasks, module: :lists
  end
  resources :org_units
  resources :tasks do
    resources :time_accountings, module: :tasks
  end
  resources :states
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/pages/index", to: 'pages#index'
  get "/pages/*page", to: 'pages#show', as: :page, format: false

  root to: 'home#index'
  mount Wobauth::Engine, at: '/auth'
end
