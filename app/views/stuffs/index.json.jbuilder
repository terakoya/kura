json.array!(@stuffs) do |stuff|
  json.extract! stuff, :id, :title, :expires_at, :unlisted, :filename, :encrypted_password
  json.url stuff_url(stuff, format: :json)
end
