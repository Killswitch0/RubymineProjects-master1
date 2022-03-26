# Подключаем класс Bridge из файла bridge.rb
require_relative "bridge"

puts "Поехали!"

sleep 1

puts "Внезапно встретелась река!"

sleep 1

# Специальный метод .new — создает объект выбранного класса. В нашем случае
# в переменной bridge будет объект класса Bridge.
bridge = Bridge.new

sleep 1

# Обратите внимание!
#
# Эта строчка выдала бы ошибку. Методы экземпляра можно вызывать только у
# конкретного объекта данного класса, а не у самого класса.
# Bridge.open

# Используем написанный нами функционал открыания моста. Проверяем состояние
# моста, открываем, если он не открыт (напомним, что условие unless выполняется при услови,
# когда наша строка кода является false)
unless bridge.is_opened?
  bridge.open
end

sleep 1

puts "Поехали дальше!"

puts bridge.is_opened?.to_s