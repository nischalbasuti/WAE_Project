json.extract! event, :id, :name, :time_start, :time_end, :created_at, :updated_at
json.url event_url(event, format: :json)
