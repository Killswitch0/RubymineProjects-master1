require_relative 'product'
require_relative 'film'
require_relative 'book'

choice = -1
products = Product.product_types.keys

while choice.negative? || choice > products.count
  puts 'Какой продукт хотите создать?'
  products.each_with_index { |p, i| puts "#{i}: #{p}" }

  choice = STDIN.gets.chomp.to_i
end

new_prod = Product.create(products[choice])

new_prod.read_from_console

puts "Какой тип хранения хотите использовать? \n1 - rexml, 2 - sqlite"
user_input = STDIN.gets.chomp.to_i

case user_input
when 1
  new_prod.save_to_xml
when 2
  new_prod.save_to_db
end








