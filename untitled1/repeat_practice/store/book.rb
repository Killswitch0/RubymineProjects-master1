class Book < Product
  def initialize(options = {})
    super

    @name = options[:name]
    @author = options[:author]
    @genre = options[:genre]
    @year = options[:year]
  end

  def to_strings
    "Название книги: #{@name}. Автор: #{@author}. Жанр: #{@genre}. Год: #{@year}. #{super}"
  end

  def read_from_console
    puts 'Название книги?'
    @name = STDIN.gets.chomp

    puts 'Автор?'
    @author = STDIN.gets.chomp

    puts 'Жанр?'
    @genre = STDIN.gets.chomp

    puts 'Год?'
    @year = STDIN.gets.chomp

    puts 'Цена?'
    @price = STDIN.gets.chomp

    puts 'Кол-во?'
    @amount = STDIN.gets.chomp
  end

  def self.read_from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map(&:chomp)

    self.new(
      name: lines[0],
      author: lines[1],
      genre: lines[2],
      year: lines[3],
      price: lines[4],
      amount: lines[5]
    )
  end
end