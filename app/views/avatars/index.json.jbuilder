json.array!(@avatars) do |avatar|
  json.extract! avatar, :id, :user_id, :generated, :image_location
  json.url avatar_url(avatar, format: :json)
end
