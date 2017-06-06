json.array!(@goods_catalogs) do |goods_catalog|
  json.extract! goods_catalog, :code, :name
  json.url goods_catalog_url(goods_catalog, format: :json)
end