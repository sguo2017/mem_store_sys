json.array!(@mem_levels) do |mem_level|
  json.extract! mem_level, :code, :name, :district, :score
  json.url mem_level_url(mem_level, format: :json)
end