json.array!(@color_pages) do |color_page|
  json.extract! color_page, :name, :begin_time, :end_time, :profile, :avatar, :content, :accept_users_type
  json.url color_page_url(color_page, format: :json)
end