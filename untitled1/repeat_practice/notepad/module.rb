module Saving
  def file_path
    current_path = File.dirname(__FILE__ )

    file_name = @created_at.strftime("#{self.class.name}_%Y.%m.%d, %H:%M:%S_txt")

    "#{current_path}/#{file_name}"
  end

  def save
    file = File.new(file_path, 'w:UTF-8')

    to_strings.each { |i| file.puts(i) }

    file.close
  end
end

module Animation
  def loading(time)
    puts 'Loading...'

    3.times do
      loading = 0

      while loading < time
        %w[* * * * *].each do |i|
          print i
          sleep 0.1

          loading += 1
        end
      end
    end

    puts 'Запись успешно сохранена в блокнот :)'
  end
end
