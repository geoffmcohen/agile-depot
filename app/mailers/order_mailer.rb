class OrderMailer < ApplicationMailer
	default from: 'The Fruit Store'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.recieved.subject
  #
  def recieved(order)   
  	  @order = order
  	  mail to: order.email, subject: 'Fruit Store Order Confirmation'    
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
  	  @order = order
  	  mail to: order.email, subject: 'Fruit Store Order Shipped'
  end
 
end
