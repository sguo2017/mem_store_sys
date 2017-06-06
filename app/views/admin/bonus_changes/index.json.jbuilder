json.array!(@bonus_changes) do |bonus_change|
  json.extract! bonus_change, :score, :red_packet
  json.url bonus_change_url(bonus_change, format: :json)
end