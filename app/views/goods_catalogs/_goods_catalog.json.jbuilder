json.extract! goods_catalog, :id, :code, :name, :created_at, :updated_at
json.url goods_catalog_url(goods_catalog, format: :json)
