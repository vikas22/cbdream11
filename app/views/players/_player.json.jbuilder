json.extract! player, :id, :name, :team_id, :user_id, :is_captain, :is_vice_captain, :created_at, :updated_at
json.url player_url(player, format: :json)
