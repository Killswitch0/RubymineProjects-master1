require_relative 'product'
require_relative 'module'
require_relative 'film'
require_relative 'book'

choice = -1
products = Product.product_types

while choice.negative? || choice > products.count
  puts 'Какой продукт хотите создать?'

  products.each_with_index do |p, i|
    puts "#{i}: #{p}"
  end

  choice = STDIN.gets.chomp.to_i
end

puts 'Укажите цену продукта?'
price = STDIN.gets.chomp.to_i

puts 'Укажите кол-во на складе?'
amount = STDIN.gets.chomp.to_i

product = Product.product_types[choice].new(price: price, amount: amount)

product.read_from_console

product.save_to_xml('/data/rexml/products.xml')











