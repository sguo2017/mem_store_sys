json.array!(@color_page_accept_users) do |color_page_accept_user|
  json.extract! color_page_accept_user, :color_page_id, :user_id, :status
  json.url color_page_accept_user_url(color_page_accept_user, format: :json)
end