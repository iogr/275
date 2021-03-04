require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/film'
require_relative 'lib/disc'
require_relative 'lib/basket'
require_relative 'lib/product_collection'

collection = ProductCollection.from_dir(File.dirname(__FILE__) + '/data')
collection.sort!(by: :price, order: :asc)

products = collection.product_list

basket = Basket.new

user_input = 1

puts "What goods do you want to buy? Type 0 for quit.\n\n"

until products.empty? || user_input.zero?
  products.each_with_index do |product, index|
    puts "#{index + 1}: #{product}"
  end

  user_input = STDIN.gets.to_i

  if user_input.between?(1, products.size)

    selected_product = products[user_input - 1]

    if selected_product.amount.positive?
      basket.add_to_cart(selected_product)
      basket.cost_of_product(selected_product)

      products.delete(selected_product) if selected_product.amount.zero?

      puts "You added: #{selected_product}"
    end
  end
end

if basket.total.positive?
  puts "You've bought: #{basket.result}"
  puts "Total: #{basket.total} rub."
else
  puts 'Well, thanks for coming.'
end
