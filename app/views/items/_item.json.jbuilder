json.extract! item, :id, :user_id, :name, :start_date, :category, :detail, :created_at, :updated_at
json.url item_url(item, format: :json)
