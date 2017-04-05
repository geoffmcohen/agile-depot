require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "recieved" do
    mail = OrderMailer.recieved(orders(:one))
    assert_equal "Fruit Store Order Confirmation", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal "The Fruit Store", mail.from
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "Fruit Store Order Shipped", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal "The Fruit Store", mail.from    
  end
end
