json.array!(@tech_servs) do |tech_serv|
  json.extract! tech_serv, :content
  json.url tech_serv_url(tech_serv, format: :json)
end