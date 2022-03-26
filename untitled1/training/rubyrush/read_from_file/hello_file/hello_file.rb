# Определим папку, в которой лежит эта программа "hello_file.rb" с помощью
# специального служебного объекта Ruby __FILE__ и метода dirname класса File. В
# этой папке мы и будем хранить созданный файл!
current_path = File.dirname(__FILE__ )

# Создаем переменную с именем фалйа "hello"
file_name = "hello"

# Переменная с текстом, который мы будем записывать в файл!
text = "Hello, File!"

# Создаем новый файл в режиме append, т. е. если файл не существует, он будет
# создан заново, если существует — он будет открыт для записи в конец файла.
file = File.new(current_path + "/" + file_name + ".txt", "a:UTF-8")

# На объекте file мы вызовем метод puts, в параметрах вкладываем переменную text,
# благодаря чему запишем содержимое переменной в наш файл!
file.puts(text)
# Как сделали все необходимые действия с файлом, закрываем его
file.close

# Если код дошел до этой строчки - файл успешно создан
# Оповестим пользователя об этом!
puts "Файл #{file_name}.txt успешно создан!"


