json.array!(@mem_groups) do |mem_group|
  json.extract! mem_group, :city, :province, :country
  json.url mem_group_url(mem_group, format: :json)
end