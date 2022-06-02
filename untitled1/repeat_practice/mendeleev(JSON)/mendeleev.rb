require 'json'

file = File.read('elements.json', encoding: 'UTF-8')
elements = JSON.parse(file)

puts 'Вот такие элементы у нас есть:'
puts elements.keys.join(', ')

puts "\nОткрывателя какого элемента вы хотите узнать?"
user_input = STDIN.gets.capitalize.chomp

elements.each do |el, disc|
  if el == user_input
    puts "Открывателем #{el} был #{disc}"
  end
end