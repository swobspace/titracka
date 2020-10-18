Rails.application.routes.draw do
  get ':date', to: 'workdays#by_date', constraints: {date: /2\d\d\d-\d\d-\d\d/ }
  get 'workdays/:date', to: 'workdays#by_date', constraints: {date: /2\d\d\d-\d\d-\d\d/ }
  resources :workdays do
    member do
      get 'by_date'
    end
  end
  resources :time_accountings
  resources :lists
  resources :org_units
  resources :tasks
  resources :states
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/pages/index", to: 'pages#index'
  get "/pages/*page", to: 'pages#show', as: :page, format: false

  root to: 'workdays#by_date', date: Date.today.to_s
  mount Wobauth::Engine, at: '/auth'
end
