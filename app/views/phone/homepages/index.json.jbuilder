json.array!(@homepages) do |homepage|
  json.extract! homepage, 
  json.url homepage_url(homepage, format: :json)
end