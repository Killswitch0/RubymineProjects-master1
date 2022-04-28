require_relative 'product'
require_relative 'film'
require_relative 'book'
require_relative 'product_collection'

film = Film.new(
  title: 'Дневник Памяти',
  director: 'Ник Кассаветис',
  genre: 'Драма',
  year: 2002,
  price: 2000,
  amount: 5
)

puts film.to_strings

puts
puts


choice = -1
choicer = Product.product_types

puts 'Какой продукт желаете создать?'

until choice >= 0 && choice < choicer.size
  choicer.each_with_index do |p, i|
    puts "\t#{i}: #{p}"
  end

  choice = STDIN.gets.chomp.to_i
end

new_prod = Product.create(choice)

new_prod.read_from_console

new_prod.save_to_txt

puts
puts "\n\n А сейчас мы прочитаем продукты ;) \n\n"

collection = ProductCollection.from_dir("#{File.dirname(__FILE__)}/data")

collection.sort!(by: :title)

collection.to_a.each { |product| puts product.to_strings }

puts 'Все топчик!'






