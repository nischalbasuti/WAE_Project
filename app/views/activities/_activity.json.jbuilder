json.extract! activity, :id, :name, :description, :start_time, :end_time, :event_id, :created_at, :updated_at
json.url activity_url(activity, format: :json)
