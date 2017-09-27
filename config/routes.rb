Rails.application.routes.draw do

  namespace :phone do
    resources :coupons
  end
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
    resources :color_pages
    resources :users
    resources :coupon_instances
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
    resources :red_packet_base_rates
    resources :coupons
    resources :coupon_instances
  end

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users
  #用户上传当前地址
  post "phone/uploadLocation", to: "phone/profiles#uploadLocation"
  #设置店铺管理员
  post "admin/stores/set_store_admin", to: "admin/stores#setStoreAdmin"
  #获取店铺的用户用户列表
  get "admin/users_of_store", to: "admin/stores#getUsers"
  #短链接
  get "s/:url", to: "short_urls#redirect"
  #商品实例扫码短链接
  get "g/:good_instance_code", to: "short_urls#scan_redirect"
  #核销订单
  get "admin/coupon_instances_write_off", to: "admin/coupon_instances#index_write_off"
  post "admin/coupon_instances_write_off", to: "admin/coupon_instances#write_off"
  root 'welcome#index'

end
