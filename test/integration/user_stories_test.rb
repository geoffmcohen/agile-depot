require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
	fixtures :products
	include ActiveJob::TestHelper
	
	# A user goes to the index page, They select a product, adding it to their cart,
	# and check out, fill in their details on the checkout form.  When they submit, an order
	# is created containing their informatino, along with a signle line item corresponding
	# to the product they added to their cart
	
	test "buying a product" do	
		
		# Keep track of the number of orders at the start of the test
		start_order_count = Order.count		
		ruby_book = products( :ruby )
		
		# Get the index page
		get "/"
		assert_response :success
		assert_select 'h1', "Fruits for Sale!!!"
		
		# Add the ruby book to the cart by creating a line item
		post '/line_items', params: { product_id: ruby_book.id }, xhr: true
		assert_response :success
		
		# Get the cart and check its contents
		cart = Cart.find(session[:cart_id])
		assert_equal 1, cart.line_items.size
		assert_equal ruby_book, cart.line_items[0].product
		
		# Get the check out page
		get "/orders/new"
		assert_response :success
		assert_select 'legend', 'Please Enter Your Details'
				
		perform_enqueued_jobs do
			
			# Fill out the check out form
			post "/orders", params: {
					order: {
						name: "Dave Thomas",
						address: "123 The Street",
						email: "dave@example.com",
						pay_type: "Check"
					}
			}
			
			# Follow the redirect to the store index page
			follow_redirect!
			
			# Check we are back on the index page and the cart is now empty
			assert_response :success
			assert_select 'h1', "Fruits for Sale!!!"
			cart = Cart.find(session[:cart_id])
			assert_equal 0, cart.line_items.size
			
			# Check that the order count increased and find the last order
			assert_equal start_order_count + 1, Order.count
			order = Order.last
			
			# Check the order details
			assert_equal "Dave Thomas", order.name
			assert_equal "123 The Street", order.address
			assert_equal "dave@example.com", order.email
			assert_equal "Check", order.pay_type
			
			assert_equal 1, order.line_items.size
			line_item = order.line_items[0]
			assert_equal ruby_book, line_item.product
			
			# Check the order confirmation email
			mail = ActionMailer::Base.deliveries.last
			assert_equal ["dave@example.com"], mail.to
			assert_equal 'The Fruit Store', mail.from
			assert_equal "Fruit Store Order Confirmation", mail.subject			
	  end
	end       
end
