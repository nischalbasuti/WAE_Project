Rails.application.routes.draw do

  resources :profiles do
    get 'events/:events', action: :events, on: :collection
  end
  resources :departments
  resources :forums do
    collection do
      post :new_forum
      get :manage
      post :update_forum_commenter
      post :delete_forum_commenter
    end
  end
  resources :requirements do
      collection do
      get :unapproved
      get :approve
    end
  end
  resources :activities do
    collection do
      post :update_activities
    end
  end
  resources :user_management do
    collection do
      get :ban
      get :unban
      get :profile
      get :statistic_users
    end
  end
  resources :events do
    collection do
      get :manage
      post :update_coordinator_privilage
      post :update_user_event
      post :delete_user_event
      post :register
      post :unregister
      post :update_activities
    end
  end
  get 'ps4/index'
  scope defaults: (Rails.env.production? ? { protocol: 'https' } : {}) do
    devise_for :users, :controllers => {:registrations => "registration"}
  end
  # login with google
  get 'login', to: 'logins#new'
  get 'login/create', to: 'logins#create', as: :create_login
  # root 'home#index'
  root 'events#index'
  get 'profile/events'
  get 'ps2/index'
  get 'ps2/quotation'
  get 'ps1/index'
  get 'ps1/divide'
  get 'ps1/divide_exception'
  get 'ps1/news'
  get 'home/index'
  get 'ps2/export'
  get 'ps2/kill_quote'
  get 'ps2/revive_quotes'
  get 'user_management/show'
  get 'user_management/ban'
  get 'user_management/unban'
  get 'user_management/statistic_users'
  get 'user_management/index'
  get 'user_management/user_manage_features'
  get 'user_management/user_statistics'
  get 'user_management/basic_user_page'
  get 'user_management/profile'
  get 'user_management/edit'
  post '/profile/update'
  post 'users/sign_up'
  post 'user_management/edit'
  post 'ps2/import'
  post 'ps2/quotation'
  post 'user_management/update_users'

  mount Commontator::Engine => '/commontator'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
