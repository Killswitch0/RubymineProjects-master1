require 'rexml/document'
require 'date'

file_name = File.dirname(__FILE__ ) + '/my_expenses.xml'

abort "Файл #{file_name} не найден." unless File.exist?(file_name)

file = File.new(file_name)

doc = REXML::Document.new(file)

amount_by_day = {}

doc.elements.each('expenses/expense') do |item|
  loss_sum = item.attributes['amount'].to_i
  loss_date = Date.parse(item.attributes['date'])

  amount_by_day[loss_date] ||= 0

  amount_by_day[loss_date] += loss_sum
end

file.close

sum_by_month = {}

curent_month = amount_by_day.keys.sort[0].strftime('%B %Y')

amount_by_day.keys.sort.each do |key|
  sum_by_month[key.strftime('%B %Y')] ||= 0
  sum_by_month[key.strftime('%B %Y')] += amount_by_day[key]
end

puts "----------[ #{curent_month}, всего потрачено: #{sum_by_month[curent_month]} грн. ]----------"

amount_by_day.keys.sort.each do |key|
  if key.strftime('%B %Y') != curent_month
    curent_month = key.strftime('%B %Y')

    puts "----------[ #{curent_month}, всего потрачено: #{sum_by_month[curent_month]} грн. ]----------"
  end

  puts "\t#{key.day}: #{amount_by_day[key]} грн."
end