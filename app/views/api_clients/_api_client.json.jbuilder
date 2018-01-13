json.extract! api_client, :id, :name, :app_token, :app_secret, :is_active, :created_at, :updated_at
json.url api_client_url(api_client, format: :json)
