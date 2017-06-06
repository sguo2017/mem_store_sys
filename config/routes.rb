Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    resources :tech_servs
  end
  namespace :admin do
    resources :goods_catalogs
  end
  devise_for :users
  

end
