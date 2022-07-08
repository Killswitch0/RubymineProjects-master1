require 'date'

# Класс Task - разновидность базового класса Post
# позволяет записывать задачи со сроком выполнения в блокнот
class Task < Post
  def initialize
    super

    @deadline = nil
  end

  def read_from_console
    puts 'Какую задачу хотите поставить?'
    @text << STDIN.gets.chomp

    puts 'К какому чилу нужно выполнить? Укажите в формате ДД.ММ.ГГ (например 25.05.2022)'
    @deadline = Date.parse(STDIN.gets.chomp)
  end

  def to_strings
    time_str =  "Создано #{@created_at.strftime('%Y.%d.%m, %H-%M')}"

    due_date = "Сделать до #{@deadline}"

    [time_str, @text, due_date]
  end

  def to_db_hash
    super.merge(
      {
        'text' => @text,
        'due_date' => @deadline.to_s
      }
    )
  end

  def load_data(data_hash)
    super(data_hash) # сперва дергаем родительский метод для инициализации общих полей

    # теперь прописываем свое специфичное поле
    @deadline = Date.parse(data_hash['deadline'])
  end
end