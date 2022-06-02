require 'rexml/document'
require 'date'

file_path = File.dirname(__FILE__ ) + '/wishes.xml'

abort "Файл #{file_path} не найден" unless File.exist?(file_path)

puts 'Какое желание хотите сохранить в сундук?'
wish_input = STDIN.gets.chomp

puts 'До какого числа ваше желание должно исполниться? (в формате ДД.ММ.ГГГГ)'
deadline = Date.parse(STDIN.gets.chomp)

file = File.new(file_path, 'r:UTF-8')
doc = REXML::Document.new(file)
file.close

wishes = doc.elements.find('wishes').first
wish = wishes.add_element 'wish', {
  'date' => deadline
}

wish.text = wish_input

file = File.new(file_path, 'w:UTF-8')
doc.write(file, 2)
file.close

puts 'Желание успешно сохранено в сундук!'

wish_dates = {}

granted_wishes = {}
wishes_come_true = {}

file = File.new(file_path, 'r:UTF-8')
doc = REXML::Document.new(file)
file.close

doc.elements.each('wishes/wish') do |el|
  wish_date = el.attributes['date']
  wish_dates[wish_date] = el.text.strip
end

wish_dates.each do |k, v|
  if k <= Date.today.to_s
    granted_wishes[k] = v
  else
    wishes_come_true[k] = v
  end
end

puts "\n\tЖелания, которые исполнились:"
granted_wishes.each { |d, w| puts "#{d}: #{w}" }

puts "\tЖелания, которым предстоит исполниться:"
wishes_come_true.each { |d, w| puts "#{d}: #{w}" }








