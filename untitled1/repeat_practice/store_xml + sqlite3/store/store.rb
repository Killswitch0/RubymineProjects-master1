require_relative 'product'
require_relative 'film'

store_choice = nil

until store_choice == 1 || store_choice == 2
  puts 'Содержание какого хранилища хотите посмотреть?'
  puts "Выберите один из вариантов: \n1 - хранилище xml, 2 - хранилище sql"
  store_choice = STDIN.gets.chomp.to_i

  store = case store_choice
          when 1
            Product.read_from_xml('data/rexml/products.xml')
          when 2
            Product.read_from_db
          end
end

choice = nil
total_price = 0

while choice != 'x'
  Product.showcase(store)

  choice = STDIN.gets.chomp

  if choice != 'x' && choice.to_i < store.size && choice.to_i >= 0
    product = store[choice.to_i - 1]
    total_price += product.buy
  elsif choice == 'x'
    puts "Спасибо за покупку, с вас #{total_price}грн :)"
  end
end

