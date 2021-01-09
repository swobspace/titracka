Rails.application.routes.draw do
  resources :references
  get 'home/index'
  get 'home', to: 'home#index'
  get ':date', to: 'workdays#by_date', as: 'by_date', constraints: {date: /\d\d\d\d-\d\d-\d\d/ }
  get 'workdays/:date', to: 'workdays#by_date', constraints: {date: /\d\d\d\d-\d\d-\d\d/ }
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
  resources :org_units do
    resources :tasks, module: :org_units
  end
  get 'cards', to: 'tasks#index', defaults: {view: 'cards'}
  post "tasks", to: "tasks#index", constraints: lambda {|req| req.format == :json}
  resources :tasks do
    collection do
      # get :search
      # post :search
      get :search_form
    end
    resources :time_accountings, module: :tasks
    resources :notes, module: :tasks
  end
  resources :states do
    resources :tasks, except: [:index, :show], module: :states
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/pages/index", to: 'pages#index'
  get "/pages/*page", to: 'pages#show', as: :page, format: false

  root to: 'home#index'
  mount Wobauth::Engine, at: '/auth'
end
