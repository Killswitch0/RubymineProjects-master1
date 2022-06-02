require 'json'

file = File.read('business_card.json', encoding: 'UTF-8')
card = JSON.parse(file)

card.each do |key, field|
  field.each do |key, val|
    puts val
  end
end

