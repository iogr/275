require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/film'
require_relative 'lib/disc'
require_relative 'lib/shopping_cart'
require_relative 'lib/product_collection'

require 'pry'

collection = ProductCollection.from_dir(File.dirname(__FILE__) + '/data')
collection.sort!(by: :price, order: :asc)

cart = ShoppingCart.new

user_input = 1

puts "What goods do you want to buy? Type 0 for quit.\n\n"
# pry.binding
until collection.to_a.empty? || user_input.zero?
  puts collection
  collection.to_s.each_with_index do |product, index|
    puts "#{index + 1}: #{product}"
  end

  user_input = STDIN.gets.to_i

  collection.update_products_in_stock!
  pry.binding
  if user_input.between?(1, products.size)
    selected_product = products[user_input - 1]

    if selected_product.amount.positive?
      cart.add_to_cart(selected_product)

      products.delete(selected_product) if selected_product.amount.zero?

      puts "You added: #{selected_product}"
    end
  end
end

if cart.empty?
  puts "You've bought: #{cart.result}"
  puts "Total: #{cart.total} rub."
else
  puts 'Well, thanks for coming.'
end
