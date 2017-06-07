Rails.application.routes.draw do
  namespace :phone do
    resources :homepages
  end
  namespace :admin do
    resources :homepages
  end
  namespace :admin do
    resources :bonus_changes
    resources :mem_groups 
    resources :mem_levels 
    resources :stores
    resources :goods
    resources :tech_servs
    resources :goods_catalogs
  end

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users
  

end
