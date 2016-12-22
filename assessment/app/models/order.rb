class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :checkouts
  validates :quantity, :numericality => { :greater_than_or_equal_to => 0 } 
  validates :price, :numericality => { :greater_than_or_equal_to => 0 } 

  def total_price
  	unit_price 	= self.product.price.to_f
  	quantity 	= self.quantity
  	total = (quantity * unit_price).round(2)
  	self.price = total
  end
end
