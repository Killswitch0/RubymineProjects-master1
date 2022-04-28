module Saving
  def path
    current_path = File.dirname(__FILE__)

    file_path = if self.class.to_s == Film.to_s
                  "#{current_path}/data/film/#{Time.now.strftime('%Y.%m.%d, %H:%M:%S')}"
                elsif self.class.to_s == Book.to_s
                  "#{current_path}/data/book/#{Time.now.strftime('%Y.%m.%d, %H:%M:%S')}"
                end
  end

  def product_arr
    [@name, @title, @director, @genre, @year, @price, @amount]
  end

  def save_to_txt
    file = File.new(path, 'w:UTF-8')

    product_arr.each { |l| file.puts(l) }

    file.close

    load(5)
  end

  def load(time)
    saving = %w[Saving . . . . .]

    3.times do
      load = 0

      while load < time
        saving.each do |sign|
          print sign
          sleep 0.3

          load += 1
        end
      end
    end

    puts "Продукт #{self.class} успешно создан ^_^"
  end
end