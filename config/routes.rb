Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  get 'welcome/index'

  namespace :phone do
    resources :bonus_changes
    resources :score_queries
    resources :city_selections
    resources :mem_activations
    resources :goods_details
    resources :goods
    resources :profiles
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
  
   root 'welcome#index'

end
