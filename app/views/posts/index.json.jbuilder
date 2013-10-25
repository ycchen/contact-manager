json.array!(@posts) do |post|
  json.extract! post, :user_id, :contact_id, :title, :body
  json.url post_url(post, format: :json)
end
