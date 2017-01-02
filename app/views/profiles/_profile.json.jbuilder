json.extract! profile, :id, :name, :description, :whatsapp, :phone, :birthdate, :address, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)