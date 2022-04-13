module FilmInstVar
  def arr_to_save
    [@title, @genre, @year, @director, @price, @amount]
  end
end

module BookInstVar
  def arr_to_save
    [@name, @genre, @year, @author, @price, @amount]
  end
end

module Saving
  def path
    current_path = File.dirname(__FILE__ )

    file_path = if self.class.to_s == Film.to_s
                  "#{current_path}/data/film/#{Time.now.strftime('%Y.%m.%d, %H:%M:%S')}"
                elsif self.class.to_s == Book.to_s
                  "#{current_path}/data/book/#{Time.now.strftime('%Y.%m.%d, %H:%M:%S')}"
                end
  end

  def save_to_txt
    file = File.new(path, 'w:UTF-8')

    to_strings.each { |l| file.puts(l) }

    file.close
  end
end