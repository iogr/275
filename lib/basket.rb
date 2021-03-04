class Basket
  attr_reader :total

  def initialize
    @total = 0
    @bought_items = []
  end

  def add_to_cart(product)
    @bought_items << product
    product.amount -= 1
    @total += product.price.to_i
  end

  def cost_of_product(selected_product)
    @purchase_price ||= 0
    @purchase_price += selected_product.price.to_i
  end

  def result
    @bought_items.tally.map { |key, value| "#{key} - #{value} pieces." }.join("\n")
  end
end
