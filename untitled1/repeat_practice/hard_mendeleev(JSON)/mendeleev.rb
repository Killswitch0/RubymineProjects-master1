require 'json'

file = File.read('elements.json', encoding: 'UTF-8')
elements = JSON.parse(file)

keys_arr = []

elements.keys.each_with_index do |v, i|
  keys_arr << if (i % 10).zero? && i != 0
                "#{v},\n"
              else
                "#{v}, "
              end
end

puts "\tУ нас есть такие элементы:\n\n"
keys_arr.last.gsub!(', ', ' ')
puts "#{keys_arr.join}\n\n"


puts 'Создателя какого элемента вы хотите узнать?'
user_input = STDIN.gets.capitalize.chomp

until elements.key?(user_input)
  puts 'Такого элемента нет. Попробуйте еще...'
  user_input = STDIN.gets.capitalize.chomp
end

elements.each do |key, val|
  next unless key == user_input

  val.each do |key, val|
    puts "#{key}: #{val}"
  end
end
