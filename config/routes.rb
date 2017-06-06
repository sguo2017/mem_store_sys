Rails.application.routes.draw do
  namespace :admin do
    resources :goods_catalogs
  end
  devise_for :users
  

end
