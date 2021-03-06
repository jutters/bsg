json.array!(@shops) do |shop|
  json.extract! shop, :id, :name, :site_url, comment, insider_tip, :price_segment_low, :price_segment_middle, :price_segment_high, :created_at, :updated_at
  json.url shop_url(shop, format: :json)
end
