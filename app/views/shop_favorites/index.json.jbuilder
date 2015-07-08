json.array!(@shop_favorites) do |shop_favorite|
  json.extract! shop_favorite, :id, :shop_id, :user_id
  json.url shop_favorite_url(shop_favorite, format: :json)
end
