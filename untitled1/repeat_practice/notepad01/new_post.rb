require_relative 'post'
require_relative 'memo'
require_relative 'task'
require_relative 'link'

choices = Post.post_types.keys

puts 'Типы записей в блокнот:'
choices.each_with_index { |t, i| puts "#{i}: #{t}" }

puts "\nКакой тип записи хотите создать?"
choice = STDIN.gets.chomp.to_i

new_post = Post.create(choices[choice])

new_post.read_from_console

id = new_post.save_to_db

puts "Наша запись сохранена, id = #{id}"




