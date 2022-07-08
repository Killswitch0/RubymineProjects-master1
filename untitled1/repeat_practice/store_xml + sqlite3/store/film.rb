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
    @price = STDIN.gets.chomp.to_i

    puts 'Кол-во?'
    @amount = STDIN.gets.chomp.to_i
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

  def to_xml
    product = super
    product.add_element(
      'film',
      {
        'title' => @title,
        'director' => @director,
        'genre' => @genre,
        'year' => @year
      }
    )

    product
  end

  def to_db_hash
    super.merge(
      {
        'title' => @title,
        'director' => @director,
        'genre' => @genre,
        'year' => @year
      }
    )
  end

  def load_data(data_hash)
    super(data_hash)

    @title = data_hash['title'],
    @director = data_hash['director'],
    @genre = data_hash['genre'],
    @year = data_hash['year']
  end
end