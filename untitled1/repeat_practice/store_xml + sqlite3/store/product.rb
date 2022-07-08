require 'sqlite3'
require 'rexml/document'

require_relative 'module'

class Product
  include Saving

  @@SQLITE_DATABASE = "#{File.dirname(__FILE__)}/data/db/store.sqlite"

  attr_accessor :price, :amount

  class << self
    def product_types
      { 'film' => Film, 'book' => Book }
    end

    def create(type)
      product_types[type].new
    end

    def showcase(product)
      puts 'Что вы хотите купить?'

      product.each_with_index do |p, i|
        i += 1
        puts "#{i}: #{p.to_strings}"
      end

      puts "'x' чтобы покинуть магазин"
    end

    def read_from_xml(file_name)
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

    def read_from_db
      db = SQLite3::Database.open(@@SQLITE_DATABASE)
      db.results_as_hash = true

      result = []

      query = 'SELECT * FROM products'

      statement = db.prepare(query)

      products = statement.execute!

      products.each do |film|
        prod = Film.new(
          title: film[1],
          director: film[2],
          genre: film[3],
          year: film[4],
          price: film[5],
          amount: film[6]
        )

        result.push(prod)
      end

      statement.close
      db.close

      result
    end

    def read_from_file(file_path)
      # to do
    end
  end

  def initialize(options = {})
    @price = options[:amount]
    @amount = options[:amount]
  end

  def to_strings
    "Цена: #{@price}. Остаток: #{@amount}"
  end

  def buy
    if @amount.positive?
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

  def to_db_hash
    {
      'type' => self.class.name,
      'price' => @price,
      'amount' => @amount
    }
  end

  def save_to_xml
    current_path = File.dirname(__FILE__)
    file_path = "#{current_path}/data/rexml/products.xml"

    abort "Файл #{file_name} не найден" unless File.exist?(file_path)

    file = File.new(file_path, 'r:UTF-8')
    doc = REXML::Document.new(file)
    file.close

    file = File.new(file_path, 'w:UTF-8')
    doc.root.add_element(self.to_xml)
    doc.write(file, 2)
    file.close
  end

  def save_to_db
    db = SQLite3::Database.open(@@SQLITE_DATABASE)
    db.results_as_hash = true

    db.execute(
      'INSERT INTO products (' +
        to_db_hash.keys.join(', ') +
        ')' + ' VALUES(' +
        ('?,' * to_db_hash.keys.size).chomp(',') +
        ')', to_db_hash.values
    )

    row_id = db.last_insert_row_id

    db.close

    row_id
  end

  def load_data(data_hash)
    @price = data_hash['price'].to_i,
    @amount = data_hash['amount'].to_i
  end
end