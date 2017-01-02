json.extract! order, :id, :product_id, :user_id, :quantity, :price, :duration, :due_date, :created_at, :updated_at
json.url order_url(order, format: :json)