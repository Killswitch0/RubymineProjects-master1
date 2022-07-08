# Класс Memo - разновидность базового класса Post
# позволяет создавать записи в блокнот
class Memo < Post
  def read_from_console
    puts 'Все до строчки "end" будет записано в блокнот!'
    user_input = nil

    until user_input == 'end'
      user_input = STDIN.gets.chomp
      @text << user_input
    end

    @text.pop
  end

  def to_strings
    time_string = @created_at.strftime('%Y-%m-%d, %H:%M')
    @text.unshift(time_string)
  end

  def to_db_hash
    super.merge(
      {
        'text' => @text.join('\n\r')
      }
    )
  end

  def load_data(data_hash)
    super(data_hash) # сперва дергаем родительский метод для инициализации общих полей

    # теперь прописываем свое специфичное поле
    @text = data_hash['text'].split('\n\r')
  end
end

