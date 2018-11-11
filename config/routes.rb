Rails.application.routes.draw do
  resources :departments
  resources :forums do
    collection do
      post :new_forum
    end
  end
  resources :requirements
  resources :activities
  resources :events do
    collection do
      get :manage
      post :update_user_event
      post :delete_user_event
      post :register
      post :unregister
    end
  end
  get 'ps4/index'
  scope defaults: (Rails.env.production? ? { protocol: 'https' } : {}) do
    devise_for :users
  end
  get 'ps2/index'
  get 'ps2/quotation'
  root 'home#index'
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
  get 'events/manage'
  get 'user_management/profile'
  get 'user_management/edit'
  post 'users/sign_up'
  post 'user_management/edit'
  post 'ps2/import'
  post 'ps2/quotation'
  post 'user_management/update_users'

  mount Commontator::Engine => '/commontator'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
