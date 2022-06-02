require 'rexml/document'
require 'date'

file_path = File.dirname(__FILE__ ) + '/my_expenses.xml'

abort "Файл #{file_path} не найден" unless File.exist?(file_path)

file = File.new(file_path)
doc = REXML::Document.new(file)
file.close

amount_by_day = {}
expenses_name = {}

doc.elements.each('expenses/expense') do |el|
  loss_sum = el.attributes['amount'].to_i
  loss_date = Date.parse(el.attributes['date'])
  exp_name = el.text.strip

  amount_by_day[loss_date] ||= 0
  amount_by_day[loss_date] += loss_sum
  expenses_name[loss_date] = exp_name
end

sum_by_month = {}

current_month = amount_by_day.keys.sort[0].strftime('%B %Y')

amount_by_day.keys.sort.each do |key|
  sum_by_month[key.strftime('%B %Y')] ||= 0
  sum_by_month[key.strftime('%B %Y')] += amount_by_day[key]
end

puts "----------[ #{current_month}, всего потрачено #{sum_by_month[current_month]} ]----------"

amount_by_day.keys.sort.each do |key|
  if key.strftime('%B %Y') != current_month
    current_month = key.strftime('%B %Y')

    puts "----------[ #{current_month}, всего потрачено #{sum_by_month[current_month]} ]----------"
  end

  puts "\t#{key.day} число, #{expenses_name[key]}: #{amount_by_day[key]}"
end


