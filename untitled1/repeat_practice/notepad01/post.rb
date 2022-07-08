require 'sqlite3'

# Основной класс Post, от которого наследуют дочерние классы
class Post

  @@SQLITE_DB_FILE = 'notepad.sqlite'

  def self.create(type)
    post_types[type].new
  end

  def self.post_types
    { 'Memo' => Memo, 'Task' => Task, 'Link' => Link }
  end

  def self.find_by_id(id)
    db = SQLite3::Database.open(@@SQLITE_DB_FILE)

    # 1. конкретная запись
    db.results_as_hash = true

  begin
    result = db.execute('SELECT * FROM posts WHERE rowid = ?', id)
  rescue SQLite3::SQLException => e
    puts "Exception's class: #{e.class}"
    puts "Exception: #{e.message}"
    puts "#{e.backtrace.inspect}"
    abort "Не удалось выполнить запрос в базе #{@@SQLITE_DB_FILE}"
  end

    result = result[0] if result.is_a? Array

    db.close

    if result.empty?
      puts "Такой id #{id} не найден в базе :("
      nil
    else
      post = create(result['type'])
      post.load_data(result)

      post
    end
  end

  def self.find_all(limit, type)
    db = SQLite3::Database.open(@@SQLITE_DB_FILE)
    db.results_as_hash = false

    # формируем запрос в базу с нужными условиями
    query = 'SELECT rowid, *  FROM posts '

    query += 'WHERE type = :type ' unless type.nil?
    query += 'ORDER by rowid DESC '

    query += 'LIMIT :limit ' unless limit.nil?
    
    statement = db.prepare(query)

    statement.bind_param('type', type) unless type.nil?
    statement.bind_param('limit', limit) unless limit.nil?

  begin
    result = statement.execute!
  rescue SQLite3::SQLException => e
    puts "Exception's class: #{e.class}"
    puts "Exception: #{e.message}"
    puts "#{e.backtrace.inspect}"
    abort "Не удалось выполнить запрос в базе #{@@SQLITE_DB_FILE}"
  end

    statement.close
    db.close

    result
  end

  def initialize
    @created_at = Time.now
    @text = []
  end

  def read_from_console
    # to do
  end

  def to_strings
    # to do
  end

  def save
    current_path = File.dirname(__FILE__)
    file_path = "#{current_path}/data/#{self.class} #{@created_at.strftime('%Y.%d.%m, %H-%M')}"

    file = File.new(file_path, 'w:UTF-8')

    to_strings.each { |l| file.puts(l) }

    file.close
  end

  def save_to_db
    db = SQLite3::Database.open(@@SQLITE_DB_FILE)
    db.results_as_hash = true

    db.execute(
      'INSERT INTO posts (' +
        to_db_hash.keys.join(', ') +
          ')' +
          ' VALUES (' +
          ('?,' * to_db_hash.keys.size).chomp(',') +
          ')',
        to_db_hash.values
    )

    insert_row_id = db.last_insert_row_id

    db.close

    insert_row_id
  end

  def to_db_hash
    {
      'type' => self.class.name,
      'created_at' => @created_at.to_s
    }
  end

  # получает на вход хэш-массив данных и должен заполнить свои поля
  def load_data(data_hash)
    @created_at = Time.parse(data_hash['created_at'])
  end
end