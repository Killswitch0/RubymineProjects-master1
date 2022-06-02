require 'rexml/document'

require_relative 'product'
require_relative 'film'
require_relative 'book'
require_relative 'product_collection'


products = Product.read_from_xml('data/products.xml')

choice = nil
total_price = 0

while choice != 'x'
  Product.showcase(products)

  choice = STDIN.gets.chomp

  if choice != 'x' && choice.to_i < products.size && choice.to_i >= 0
    product = products[choice.to_i]
    total_price += product.buy
  elsif choice == 'x'
    puts "Спасибо за покупку! С вас #{total_price}"
  end
end


