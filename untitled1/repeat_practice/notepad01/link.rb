require 'date'

# Класс Link - разновидность базового класса Post
# позволяет записывать в блокнот ссылки типа url
class Link < Post
  def initialize
    super

    @url = ''
  end

  def read_from_console
    puts 'Какую ссылки хотите сохранить?'
    @url = STDIN.gets.chomp

    puts 'Что за ссылка?'
    @text << STDIN.gets.chomp
  end

  def to_strings
    time_str = "Создано #{Date.parse(@created_at.strftime('%Y.%m.%d, %H-%M'))}"
    @text.unshift(time_str)

    [@text, @url]
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
    super(data_hash) # сперва дергаем родительский метод для инициализации общих полей

    # теперь прописываем свое специфичное поле
    @url = data_hash['url']
  end
end