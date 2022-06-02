require 'json'
require 'date'

file = File.read('signs.json', encoding: 'UTF-8')
signs = JSON.parse(file)

puts 'Напишите дату вашего рождения в формате ДД.ММ (например 24.02)'
user_birth_date = Date.parse(STDIN.gets.chomp + '.2000')

user_date = nil

signs.each do |key, sign|
  dates = sign['dates'].split('..')

  if (Date.parse(dates[0] + '.2000') <= user_birth_date) &&
      (user_birth_date <= Date.parse(dates[1] + '.2000'))

    user_date = sign
  end
end

puts user_date['dates']
puts user_date['text']








