class AddRentToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :duration, :integer, default: 1
    add_column :orders, :duration, :integer
    add_column :orders, :due_date, :date
  end
end
