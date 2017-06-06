json.array!(@stores) do |store|
  json.extract! store, :code, :catalog, :name, :district, :city, :province, :country, :latitude, :longitude, :addr, :linkman, :contact_num
  json.url store_url(store, format: :json)
end