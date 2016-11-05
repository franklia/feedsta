json.extract! photo, :id, :caption, :status, :position, :photo_credit, :file, :user_id, :created_at, :updated_at
json.url photo_url(photo, format: :json)