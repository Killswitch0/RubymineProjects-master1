require_relative 'module'

class Product
  include Saving

  attr_accessor :price, :amount

  def initialize(options = {})
    @price = options[:price]
    @amount = options[:amount]
  end
  
  def self.product_types
    [Film, Book]
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

  def update(options)
    @price = options[:price] if options[:price]
    @amount = options[:amount] if options[:amount]
  end
end