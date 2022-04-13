require 'date'

class Task < Post
  def initialize
    super

    @due_date = Time.now
  end

  def read_from_console
    puts 'Какую задачу хотите поставить?'
    @text = STDIN.gets.chomp

    puts 'К какому числу необходимо выполнить?'
    puts 'Укажите дату в формате ДД.ММ.ГГГГ, например 24.02.1996'
    input = STDIN.gets.chomp

    @due_date = Date.parse(input)
  end

  def to_strings
    time_string = "Создано #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}"

    deadline = "Крайний срок #{@due_date.strftime('%Y.%m.%d')}"

    [time_string, @text, deadline]
  end

  def save
    file = File.new(file_path, 'w:UTF-8')

    to_strings.each { |i| file.puts(i) }

    file.close

    puts 'Запись успешно сохранена :)'
  end
end