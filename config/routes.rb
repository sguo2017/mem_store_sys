Rails.application.routes.draw do
  resources :goods_catalogs
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
