# Класс «Ссылка», разновидность базового класса «Запись»
class Link < Post
  # Конструктор у класса «Ссылка» свой, но использует конструктор родителя.
  def initialize
    # Вызываем конструктор родителя
    super

    # Создаем специфичную для ссылки переменную экземпляра @url — адрес, куда
    # будет вести ссылка.
    @url = ''
  end

  # Напишем реализацию метода read_from_console для экземпляра ссылки. Он
  # спрашивает у пользователя адрес ссылки и её описани, которые мы записываем
  # соответственно в переменны экземпляра @url и @text.
  def read_from_console
    # Спрашиваем у пользователя url ссылки и записываем в переменную @url
    puts "Адрес ссылки:"
    @url = STDIN.gets.chomp

    # Спрашиваем у пользователя описание ссылки (одной строчки будет достаточно)
    puts "Что за ссылка?"
    @text = STDIN.gets.chomp
  end

  # Метод to_string для ссылки возвращает массив из трех строк: адрес ссылки,
  # описание ссылки и строка с датой создания ссылки.
  def to_strings
    time_string = "Создано #{@text.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"
    [@url, @text, time_string]
  end

  def to_db_hash
    super.merge(
      {
        'text' => @text,
        'url' => @url
      }
    )
  end

  def load_data(data_hash)
    super(data_hash) # сперва дергаем родительский метод для общих полей

    # теперь прописываем свое специфичное поле
    @url = data_hash['url']
  end
end