require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :product => nil,
      :user => nil,
      :quantity => 1,
      :price => "9.99"
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input#order_product_id[name=?]", "order[product_id]"

      assert_select "input#order_user_id[name=?]", "order[user_id]"

      assert_select "input#order_quantity[name=?]", "order[quantity]"

      assert_select "input#order_price[name=?]", "order[price]"
    end
  end
end
