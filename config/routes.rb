Rails.application.routes.draw do
  root 'home#index'
  get 'ps1/index'
  get 'ps1/divide'
  get 'ps1/news'
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
