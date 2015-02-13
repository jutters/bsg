json.array!(@shops) do |shop|
  json.extract! shop, :id, :name, :site_url, :image_url, :comment
  json.url shop_url(shop, format: :json)
end
