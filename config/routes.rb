Rails.application.routes.draw do
  namespace :phone do
    resources :stores
  end
  get 'welcome/index'

  namespace :phone do
    resources :activities
    resources :bonus_changes
    resources :score_queries
    resources :city_selections
    resources :mem_activations
    resources :goods_details
    resources :goods
    resources :profiles
    resources :homepages
    resources :tech_servs
    resources :sms_sends
    resources :lotteries
    resources :wxes
  end

  namespace :admin do
    resources :activities
    resources :activity_awards
    resources :activity_award_cfgs
    resources :bonus_changes
    resources :mem_groups 
    resources :mem_levels 
    resources :stores
    resources :goods
    resources :tech_servs
    resources :goods_catalogs
    resources :users
    resources :score_histories    
    resources :lotteries
  end

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users
  
  root 'welcome#index'

end
