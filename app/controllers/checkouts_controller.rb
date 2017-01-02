class CheckoutsController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: [:create] 
	def new
		@token = Braintree::ClientToken.generate
		@order = Order.find(params[:order_id])
	end


	def create
		@order = Order.find(params[:order_id])
		amount = checkout_params[:amount]
		nonce_from_the_client = checkout_params[:payment_method_nonce]
		result = Braintree::Transaction.sale(
		  :amount => amount,
		  :payment_method_nonce => nonce_from_the_client,
		  :options => {
		    :submit_for_settlement => true
		  }
		)
		@checkout = @order.checkouts.new(amount: amount)
		@checkout.save
		@order.update(paid: true)

		# Decrement product stock
		@order.product.stock -= @order.quantity
		@order.product.save
		redirect_to(order_checkout_path(@order, @checkout))
	end

	def show
		@checkout = Checkout.find(params[:id])
		@order = @checkout.order	
	end

	def checkout_params
		params.require(:checkout).permit(
			:amount,
			:payment_method_nonce
		)
	end
end
