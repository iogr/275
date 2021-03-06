class ProductCollection
  PRODUCT_TYPES = {
    film: {dir: 'films', class: Film},
    book: {dir: 'books', class: Book},
    disc: {dir: 'discs', class: Disc}
  }

  def initialize(products = [])
    @products = products
  end

  def self.from_dir(dir_path)
    products = []

    PRODUCT_TYPES.each do |type, hash|
      product_dir = hash[:dir]

      product_class = hash[:class]

      Dir[dir_path + '/' + product_dir + '/*.txt'].each do |path|
        products << product_class.from_file(path)
      end
    end

    self.new(products)
  end

  def to_a
    @products
  end

  def to_s
    @products
  end

  def update_products_in_stock!
  end

  def sort!(params)
    @products.sort_by!(&:to_s) if params[:by] == :name
    @products.sort_by!(&:price) if params[:by] == :price
    @products.sort_by!(&:amount) if params[:by] == :amount
    @products.reverse! if params[:order] == :asc

    self
  end
end
