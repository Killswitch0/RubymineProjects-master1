class Product
  attr_accessor :price, :amount

  def initialize(options = {})
    @price = options[:price]
    @amount = options[:amount]
  end
  
  def self.product_types
    [Film]
  end
  
  def self.create(type_index)
    product_types[type_index].new
  end

  def to_strings
    "Цена: #{@price}. Остаток: #{@amount}"
  end
  
  def read_from_console
    # to do
  end
  
  def self.read_from_file(file_path)
    # to do
  end

  def path
    current_path = File.dirname(__FILE__ )

    save_file_path = "#{current_path}/data/film/#{Time.now.strftime('%Y.%m.%d %H:%M:%S')}.txt"


  end

  def save_to_txt
    file = File.new(path, 'w:UTF-8')

    [@title, @director, @genre, @year, @price, @amount].each { |l| file.puts(l) }

    file.close
  end

  def update(options)
    @price = options[:price] if options[:price]
    @amount = options[:amount] if options[:amount]
  end

end