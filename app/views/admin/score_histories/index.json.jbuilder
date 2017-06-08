json.array!(@score_histories) do |score_history|
  json.extract! score_history, :point, :object_type, :object_id, :oper, :user_id
  json.url score_history_url(score_history, format: :json)
end