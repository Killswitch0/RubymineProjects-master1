puts 'Solve equation A * x^2 +B * x + C = 0'

puts 'Enter A:'
a = gets.to_f

puts 'Enter B:'
b = gets.to_f

puts 'Enter C'
c = gets.to_f

# считаем дискриминант
discr = b * b - 4 * a * c

# первый корень
x1 = (-b + Math::sqrt(discr) / (2 * a))

# второй корень
x2 = (-b - Math::sqrt(discr) / (2 * a))

puts 'Solution 1:'
puts x1

puts 'Solution 2:'
puts x2