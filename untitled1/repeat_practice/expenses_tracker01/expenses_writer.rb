require 'rexml/document'
require 'date'

puts 'На что потратили деньги?'
expense_text = STDIN.gets.chomp

puts 'Сколько потратили денег?'
expense_amount = STDIN.gets.chomp.to_i

puts 'В какую категорию занести трату?'
expense_category = STDIN.gets.chomp

puts 'Укажите дату траты в формате ДД.ММ.ГГГГ, например 05.05.2022 (пустое поле - сегодня)'
date_input = STDIN.gets.chomp

expense_date = if date_input.include?('')
                 Date.today
               else
                 Date.parse(date_input)
               end

file_path = File.dirname(__FILE__ ) + '/my_expenses.xml'

file = File.new(file_path, 'r:UTF-8')
doc = REXML::Document.new(file)
file.close

expenses = doc.elements.find('expenses').first
expense = expenses.add_element 'expense', {
  'amount' => expense_amount,
  'category' => expense_category,
  'date' => expense_date.to_s
}

expense.text = expense_text

file = File.new(file_path, 'w:UTF-8')
doc.write(file, 2)
file.close

puts 'Запись успешно сохранена!'




