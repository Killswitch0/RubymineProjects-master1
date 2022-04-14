class ProductCollection
  PRODUCT_TYPES = {
    film: {dir: 'film', class: Film},
    book: {dir: 'book', class: Book}
  }.freeze

  def initialize(products = [])
    @products = products
  end

  def self.from_dir(dir_path)
    products = []

    PRODUCT_TYPES.each do |type, hash|
      product_dir = hash[:dir]

      product_class = hash[:class]

      Dir["#{dir_path}/#{product_dir}/*"].each do |path|
        products << product_class.read_from_file(path)
      end
    end

    new(products)
  end

  def to_a 
    @products
  end

  def sort!(params)
    case params[:by]
    when :title
      @products.sort_by!(&:to_s)
    when :price
      @products.sort_by!(&:price.to_i)
    when :amount
      @products.sort_by!(&:amount.to_i)
    end
  end
end