Rails.application.routes.draw do
  resources :day_types
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
  post "time_accountings", to: "time_accountings#index", constraints: lambda {|req| req.format == :json}
  resources :time_accountings do
    collection do
      get :search
      post :search
      get :search_form
    end
  end
  resources :lists do
    resources :tasks, module: :lists
  end
  resources :org_units do
    resources :tasks, module: :org_units
    collection do
      get 'tokens'
    end
  end
  get 'cards', to: 'tasks#index', defaults: {view: 'cards'}
  post "/tasks/:task_id/time_accountings", to: "tasks/time_accountings#index", constraints: lambda {|req| req.format == :json}
  post "tasks", to: "tasks#index", constraints: lambda {|req| req.format == :json}
  resources :tasks do
    collection do
      # get :search
      # post :search
      get :search_form
      get :query
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
