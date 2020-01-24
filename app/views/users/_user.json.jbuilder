json.extract! user, :id, :email, :username, :status, :expired_at, :created_at, :updated_at
json.url user_url(user, format: :json)
