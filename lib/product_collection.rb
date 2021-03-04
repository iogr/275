class ProductCollection
  PRODUCT_TYPES = {
    film: {dir: 'films', class: Film},
    book: {dir: 'books', class: Book},
    disc: {dir: 'discs', class: Disc}
  }

  # Конструктор коллекции принимает на вход массив продуктов, но если ничего не
  # передали на вход, то он записывает в переменную экземпляра @products пустой
  # массив.
  def initialize(products = [])
    @products = products
  end

  # Метод класса (статический метод) from_dir считывает из указанной в
  # параметрах папки все файлы:
  #
  # фильмы — из dir_path + '/films';
  # книги — из dir_path + '/books';
  # альбомы — из dir_path + '/discs'.
  def self.from_dir(dir_path)
    products = []

    # Пройдемся по каждой паре ключ-значение из константы PRODUCT_TYPES и
    # поочередно запишем эту пару соответственно в переменные type и hash.
    #
    # Сначала в type будет :film, а в hash — {dir: 'films', class: Film}, потом
    # в type будет :book, а в hash — {dir: 'books', class: Book}
    #
    PRODUCT_TYPES.each do |type, hash|
      product_dir = hash[:dir]

      product_class = hash[:class]

      Dir[dir_path + '/' + product_dir + '/*.txt'].each do |path|
        products << product_class.from_file(path)
      end
    end

    self.new(products)
  end

  def product_list
    @products
  end

  # Метод sort! меняет экземпляр класса ProductCollection (меняет порядок)
  # продуктов в коллекции, поэтому он назвал с восклицательным знаком. Этот
  # метод принимает на вход ассоциативный массив, в котором могут быть два
  # ключа: :by и :order. Например, чтобы отсортировать продукты по возрастанию
  # цены, можно вызвать этот метод так:
  #
  # collection.sort!(by: :price, order: :asc)
  def sort!(params)
    @products.sort_by!(&:to_s) if params[:by] == :name
    @products.sort_by!(&:price) if params[:by] == :price
    @products.sort_by!(&:amount) if params[:by] == :amount
    @products.reverse! if params[:order] == :asc

    # Возвращаем ссылку на экземпляр, чтобы у него по цепочке можно было вызвать
    # другие методы.
    self
  end
end
