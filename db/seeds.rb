# Clear out the database
Product.delete_all

# Add some records
Product.create(title: 'Apple', description: 'Delicious red apple with a cute worm inside', image_url: 'http://images.clipartpanda.com/apple-worm-clip-art-apple-worm.png', price: 0.25)
Product.create(title: 'Banana', description: 'Ripe banana with hundreds of brown freckles', image_url: 'http://www.ownzee.com/attachments/2012/09/pic6/5060cb90-e028-433e-8f49-7887cdbab12d.jpg', price: 0.45)
Product.create(title: 'Orange', description: 'Orange colored orange with a big \'ol navel', image_url: 'https://openclipart.org/download/12991/nicubunu-Orange.svg', price: 0.60)
Product.create(title: 'Papaya', description: 'Fun to say and super tasty', image_url: 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR7ZSMOO91KP2Nkl38wFKzOP_Ih9tR7XQCWm_KcefqdTgqh9SVcmA6NqgEH', price: 2.50)



