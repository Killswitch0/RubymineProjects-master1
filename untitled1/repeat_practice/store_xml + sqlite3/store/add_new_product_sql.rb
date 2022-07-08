require_relative 'product'
require_relative 'film'
require_relative 'book'

choices = Product.product_types.keys

puts 'У нас есть такие продукты:'
choices.each_with_index do |p, i|
  puts "#{i}: #{p}"
end

puts "\nКакой продукт вы хотите создать?"
choice = STDIN.gets.chomp.to_i

new_prod = Product.create(choices[choice])

new_prod.read_from_console

new_prod.save_to_db


