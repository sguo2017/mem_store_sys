json.array!(@goods) do |good|
  json.extract! good, :code, :name, :goods_catalog, :spec, :status, :score, :ispromotion, :avatar
  json.url good_url(good, format: :json)
end