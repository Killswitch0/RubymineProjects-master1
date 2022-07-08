require_relative 'module'

class Product
  include Saving

  attr_accessor :price, :amount

  def self.product_types
    [Film, Book]
  end

  def self.create(type_index)
    product_types[type_index].new
  end

  def self.showcase(product)
    puts 'Что вы хотите купить?'

    product.each_with_index do |p, i|
      i += 1
      puts "#{i}: #{p.to_strings}"
    end

    puts "'x' чтобы покинуть магазин"
  end

  def self.read_from_xml(file_name)
    file_path = File.dirname(__FILE__) + "/#{file_name}"

    abort "Файл #{file_name} не найден" unless File.exist?(file_path)

    file = File.new(file_path)
    doc = REXML::Document.new(file)
    file.close

    result = []
    product = nil

    doc.elements.each('products/product') do |product_node|
      price = product_node.attributes['price'].to_i
      amount = product_node.attributes['amount'].to_i

      product_node.each_element('film') do |film_node|
        product = Film.new(
            price: price,
            amount: amount,
            title: film_node.attributes['title'],
            director: film_node.attributes['director'],
            genre: film_node.attributes['genre'],
            year: film_node.attributes['year']
        )
      end

      result.push(product)
    end

    result
  end

  def self.read_from_file(file_path)
    # to do
  end

  def initialize(options = {})
    @price = options[:amount]
    @amount = options[:amount]
  end

  def to_strings
    "Цена: #{@price}. Остаток: #{@amount}"
  end

  def buy
    if @amount > 0
      puts 'Поздравляю! Вы купили товар!'
      @amount -= 1
      @price
    else
      puts 'Товар закончился!'
      0
    end
  end

  def read_from_console
    # to do
  end

  def update(options)
    @price = options[:price] if options[:price]
    @amount = options[:amount] if options[:amount]
  end

  def to_xml
    res = REXML::Element.new('product')
    res.add_attributes(
      {
        'price' => @price,
        'amount' => @amount
      }
    )

    res
  end

  def save_to_xml(file_name)
    current_path = File.dirname(__FILE__)
    file_path = current_path + file_name

    abort "Файл #{file_name} не найден" unless File.exist?(file_path)

    file = File.new(file_path, 'r:UTF-8')
    doc = REXML::Document.new(file)
    file.close

    file = File.new(file_path, 'w:UTF-8')
    doc.root.add_element(self.to_xml)
    doc.write(file, 2)
    file.close
  end
end