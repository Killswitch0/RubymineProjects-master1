require 'rexml/document'

file_path = File.dirname(__FILE__ ) + "/card.xml"

abort "Файл #{file_path} не найден" unless File.exist?(file_path)

file = File.new(file_path)
doc = REXML::Document.new(file)
file.close

card = {}

['name', 'skills', 'contacts'].each do |field|
  card[field] = doc.root.elements[field].text.strip
end

puts "Меня зовут #{card['name']}"
puts "Я #{card['skills']}"
puts "Телефон: #{card['contacts']}"