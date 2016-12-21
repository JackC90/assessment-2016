class Product < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_many :customers, through: :orders, source: :users
end
