# Программа, проверяющая палиндром введенное слово или нет, версия 2, в котрой
# можно вводить строку с пробелами.

# Спрашиваем у пользователя строку и записываем её в переменную original_string
puts "Введите строку, которую надо проверить на \"палиндромность\""

# Удаляем из строки все пробелы методом delete. В скобках этот метод принимает
# строку из всех символов, которые нужно удалить. Бонусом можно было удалить все
# знаки препинания (мы — не будем). Потом переводим строку в нижний регистр.
original_string = gets.chomp.delete(" ,.!?;:-").downcase

# Получаем перевернутую строку и записываем её в переменную reverse_string.
revert_string = original_string.reverse

# Сравниваем перевернутую строку с той, которая в переменной stripped_string,
# если они совпали, это палиндром.
if revert_string == original_string
  puts "Да, это палиндром!"
else
  puts "Нет, это не палиндром"
end