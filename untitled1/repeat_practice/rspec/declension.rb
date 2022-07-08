class Declension
  def self.sklonenie(number, krokodil, krokodila, krokodilov, with_number = false)
    number = 0 if number.nil? || !number.is_a?(Numeric)

    prefix = ''
    prefix = "#{number} " if with_number

    ostatok100 = number % 100

    return "#{prefix}#{krokodilov}" if ostatok100 >= 11 && ostatok100 <= 14

    ostatok = number % 10

    return "#{prefix}#{krokodil}" if ostatok == 1

    return "#{prefix}#{krokodila}" if ostatok >= 2 && ostatok <= 4

    return "#{prefix}#{krokodilov}" if ostatok >= 5 && ostatok <= 9 || ostatok == 0
  end
end


puts Declension.sklonenie(18, 'krokodil', 'krokodila', 'krokodilov')