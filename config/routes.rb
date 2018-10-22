Rails.application.routes.draw do
  resources :events
  devise_for :users
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
  post 'ps2/import'

  post 'ps2/quotation'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
