Rails.application.routes.draw do
  get 'ps2/index'
  get 'ps2/quotation'
  root 'home#index'
  get 'ps1/index'
  get 'ps1/divide'
  get 'ps1/divide_exception'
  get 'ps1/news'
  get 'home/index'

  post 'ps2/quotation'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
