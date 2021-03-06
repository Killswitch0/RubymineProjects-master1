# Метод get_letters возвращает массив букв загаданного слова, которое было
# передано программе в консоли в качестве параметра.
def get_letters
  slovo = ARGV[0]

  if slovo == nil || slovo == ""
    abort "Вы не ввели слово для игры"
  end

  # Разбиваем слово на буквы специальным методом split, который есть у всех
  # объектов класса Строка.
  #
  # Этот метод на вход принимает другую строку (разделитель) и разбивает
  # исходную на массив строк с указанными разделителем. Если в качестве
  # разделитея передать пустую строку (""), метод разобьет строку на символы.
  return slovo.split("")
end

# Метод get_user_input занимается лишь тем, что спрашивает у пользователя,
# какую букву он хочет попробовать в качестве следующего хода.
def get_user_input
  letter = ""

  # Если при запуске программы не указали слово для отгадывания, мы не можем
  # продолжать игру, вылетаем с ошибкой
  while letter == ""
    # Спрашиваем у пользователя букву в консоли. Обратите внимание, что вместо
    # gets надо использовать STDIN.gets — особенность руби при использовании
    # аргументов в командной строке (массива ARGV).
    letter = STDIN.gets.chomp
  end

  return letter
end

#по текущему вводу пользователя, загаданной букве, массивам угаданных и не угаданных букв, определить, что произошло:
#либо пользователь угадал все слово - возвращаем 1, пользователь не угадал букву - возвращаем -1
def check_result(user_input, letters, good_letters, bad_letters)

  if good_letters.include?(user_input) || bad_letters.include?(user_input)
    return 0
  end

  #Тут мы добавили список проверок на предмет того, ввёл ли пользователь букву, которая заодно
  # открывала бы вторую букву, которая состоит с ней в паре, например ("е-ё/ё-е", "и-й/й-и"), благодаря чему
  # облегчали процесс разгадывания слова.
  if letters.include?(user_input) ||
    (user_input ==  "е" && letters.include?("ё")) ||
    (user_input ==  "ё" && letters.include?("е")) ||
    (user_input ==  "и" && letters.include?("й")) ||
    (user_input ==  "й" && letters.include?("и"))
    # В любом (поэтому эти условия объединяет оператор ||) из этих случаев мы
    # добавляем в массив хороших букв ту, что была введена пользователем и
    # её подружку, если есть (считаем «подружками» е + ё» и и + й)
    good_letters << user_input

    if user_input == "е"
      good_letters << "ё"
    elsif user_input == "ё"
      good_letters << "е"
    end

    if user_input == "и"
      good_letters << "й"
    elsif user_input == "й"
      good_letters << "и"
    end

    # Так как мы поменяли логику и массив good_letters может содержать не только
    # буквы, которые есть в слове, но и их «подружек», сравнение массивов даст
    # теперь неверный результат.
    #
    # Для правильной проверки мы используем возможность руби «вычесть» один
    # массив из другого. Эта операция возвращает только те элементы первого
    # массива, которых нет во втором.
    #
    # https://ruby-doc.org/core-2.4.0/Array.html#method-i-2D
    #
    # Если мы из всех букв загаданного слова уберем все «хорошие» буквы, то
    # останется массив, содержащий буквы, которые еще не отгаданы. Если этот
    # массив пуст, значит мы угадали все слово. Бинго!
    #
    # Проверить массив на «пустоту» (что в нем нет элементов), можно с помощью
    # метода .empty?
    #
    # https://ruby-doc.org/core-2.4.0/Array.html#method-i-empty-3F
    if (letters - good_letters).empty?
      return 1
    else
      return 0
    end
  else
    bad_letters << user_input
    return -1
  end
end

# Метод get_word_for_print возвращает нам загаданное слово для вывода на экран:
# если буква отгадана, она отображается, иначе вместо неё отображаются
# подчеркивания.
#
# Например, если слово было «молоко» и отгадали буквы «о» и «к», то метод должен
# вернуть строку "__ о __ о к о".
def get_word_for_print(letters, good_letters)
  result = ""
  
  letters.each do |letter|
    if good_letters.include?(letter)
      result += letter + " "
    else
      result += "__ "
    end
  end

  return result
end

# Метод print_status выводит на экран текущий статус игры. В качестве входных
# параметров ему нужна вся доступная информация об игре: массив загаданного
# слова, массивы «хороших» и «плохих» букв и общее число сделанных ошибок.
def print_status(letters, good_letters, bad_letters, errors)
  puts "\nСлово: " + get_word_for_print(letters, good_letters)
  #метод join, вызванный к массиву, выводит все его элементы в строку,
  # разделяя его тем, что идет в параметрах этого метода
  # это похоже на вызов метода to_s, только join собирает все элементы массива в одну строчку,
  # без скобок, кавычек и т.п.
  puts "Ошибки (#{errors}): #{bad_letters.join(", ")}"
  puts "Угаданные буквы: #{good_letters.size}"

  if errors >= 7
    puts "Вы проиграли:("
  else
    if (letters - good_letters).empty?
      puts "Поздравляю! Вы выиграли :)\n\n"
    else
      puts "У вас осталос попыток: " + (7 - errors).to_s
    end
  end
end



