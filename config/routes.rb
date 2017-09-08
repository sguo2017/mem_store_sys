Rails.application.routes.draw do

  namespace :admin do
    namespace :report do
      resources :flow_analyses
      resources :page_analyses
      resources :mem_analyses
      resources :region_analyses
      resources :trend_analyses
      resources :scan_geographical_distributions
      resources :month_scans
    end
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
    resources :stores
    resources :invitations
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
    resources :good_instances
    resources :qr_code_scan_histories
    resources :config_table_infos
    resources :red_packet_histories
    resources :ad_modifies
  end

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users
  get "s/:url", to: "short_urls#redirect"
  root 'welcome#index'

end
