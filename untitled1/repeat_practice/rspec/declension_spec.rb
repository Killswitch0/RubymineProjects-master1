### # Когда нужно писать тесты?  ###
# 1. когда я пишу методы классов
# 2. если я уже нашел в своей программе баг
# 3. проверяйте граничные условия:
# если у вас принципиально разное поведение программы,
# какие-то очень большие числа или очень маленькие, то
# на каждую ситуацию следует написать по одному тесту!
# Например пишу программу, которая тестирует офис из 100 пк
# на наличие сети, следует обязательно проверить:
# например указать 0 - если вообще ни одного пк не будет в офисе
#
# 4. если есть малейшее сомнения на работоспособность кода, то
# необходимо на участок сомнения написать тест.

require 'rspec'

require_relative 'declension'

describe 'Declension' do

  it 'should do ok for KROKODILOV' do
    expect(Declension.sklonenie(25, 'krokodil', 'krokodila', 'krokodilov')).to eq 'krokodilov'
  end

  # автоматизированный сценарий
  it 'should do ok for KROKODILOV_automated' do

    [5, 6, 7, 8, 9, 0].each do |number|

      (0..100).step(10) do |i|
        summa = i + number

        expect("#{summa} #{Declension.sklonenie(summa, 'krokodil', 'krokodila', 'krokodilov')}").to eq "#{summa} krokodilov"
      end
    end
  end

    # простые случае для КРОКОДИЛ
    it 'should be ok for KROKODIL' do
      [1, 21, 31, 141].each do |i|
        expect(Declension.sklonenie(i, 'krokodil', 'krokodila', 'krokodilov', true)).to eq "#{i} krokodil"
      end
    end


  # простые случае для КРОКОДИЛА
  it 'should be ok for KROKODIL' do
    [2, 3, 4, 22, 33, 144].each do |i|
      expect("#{i} #{Declension.sklonenie(i, 'krokodil', 'krokodila', 'krokodilov')}").to eq "#{i} krokodila"
    end
  end

  # простые случае для КРОКОДИЛА
  it 'should be ok for KROKODILOV_special' do
    [10, 11, 12, 13, 14, 111, 312, 1013, 2114].each do |i|
      expect("#{i} #{Declension.sklonenie(i, 'krokodil', 'krokodila', 'krokodilov')}").to eq "#{i} krokodilov"
    end
  end
end
