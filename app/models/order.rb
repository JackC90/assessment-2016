class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :checkouts, dependent: :destroy
  validates :quantity, :numericality => { :greater_than_or_equal_to => 0 } 
  validates :price, :numericality => { :greater_than_or_equal_to => 0 } 

  scope :relevant, -> (user) { where("user_id = ? OR product_id IN (?)", user.id, user.products.pluck(:id)) }
  scope :as_customer, -> (user) { where("user_id = ?", user.id) }
  scope :as_vendor,   -> (user) { where("product_id IN (?)", user.products.pluck(:id)) }

  def calculate_total_price
  	unit_price 	= self.product.price.to_f
    discounted = 1.00 - (self.product.discount * 0.01)
  	quantity 	= self.quantity

    if self.product.for_rent? && self.duration.present?
      duration = self.duration
    else
      duration = 1
    end

  	total = (quantity * duration * unit_price * discounted).round(2)
  	self.price = total
  end

  def calculate_due_date
    if self.product.for_rent? && self.duration.present?
      self.due_date = Date.today + self.duration.months
    end
  end
end
