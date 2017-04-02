class AddCurrentPriceToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_column :line_items, :price, :decimal
    
    # Set the price on each line item that already exists
    LineItem.all.each do |item|
    	item.price = item.product.price
    	item.save!
    end
  end
end
