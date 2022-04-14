class Film < Product
  attr_accessor :title,
                :director,
                :genre,
                :year

  def initialize(options = {})
    super

    @title = options[:title]
    @director = options[:director]
    @genre = options[:genre]
    @year = options[:year]
  end

  def to_strings
    "Фильм: #{@title}. Режиссер: #{@director}. Жанр: #{@genre}. Год: #{@year}. #{super}"
  end

  def read_from_console
    puts 'Какой фильм хотите добавить?'
    @title = STDIN.gets.chomp

    puts 'Кто режиссер?'
    @director = STDIN.gets.chomp

    puts 'Жанр?'
    @genre = STDIN.gets.chomp

    puts 'Год?'
    @year = STDIN.gets.chomp

    puts 'Цена?'
    @price = STDIN.gets.chomp

    puts 'Количество?'
    @amount = STDIN.gets.chomp
  end

  def self.read_from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map(&:chomp) # alternative { |i| i.chomp }

    new(
      title: lines[0],
      director: lines[1],
      genre: lines[2],
      year: lines[3],
      price: lines[4],
      amount: lines[5]
    )
  end
end