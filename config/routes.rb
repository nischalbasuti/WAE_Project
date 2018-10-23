Rails.application.routes.draw do
  resources :events
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
  post 'ps2/import'
  post 'ps2/quotation'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
