json.array!(@contests) do |contest|
  json.extract! contest, :id, :title, :poster, :description, :user_id, :poll
  json.url contest_url(contest, format: :json)
end
