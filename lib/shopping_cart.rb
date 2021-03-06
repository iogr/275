class ShoppingCart
  def initialize
    @bought_items = []
  end

  def add_to_cart(product)
    @bought_items << product
    product.amount -= 1
  end

  def total
    @bought_items.sum { |product| product.price }
  end

  def to_s
    @bought_items.tally.map { |key, value| "#{key} - #{value} pieces." }.join("\n")
  end
end
