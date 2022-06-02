# модуль Debugger отвечает за то, какие непосредственно модули
# включать в наш класс. Чтобы каждый раз не писать:
# extend ClassMethod, include InstanceMethods.
#
# Когда мы подключаем модуль в класс, вызывая метод include,
# в этот момент срабатывает его внутренний метод - included(hook).
# Учитывая это, мы может сделать:
module Debugger
  # self в данном случае означает, что этот метод не включается в класс,
  # в который мы его подключаем, а он являтся методом модуля.
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def debug(log)
      puts "DEBUG: #{log}!!!"
    end
  end

  module InstanceMethods
    def debug(log)
      self.class.debug(log)
    end
  end

  def print_class
    puts self.class
  end
end

module SystemsCheck
  def check_rpm
    "Текущие обороты двигателя #{self.class}: #{self.current_rpm}"
  end

  def check_tires
    if tire_pressure < 2.2
      puts "Tire pressure #{self.class}: #{self.tire_pressure}...bad"
      puts 'ATTENTION [!YOU NEED TO PUMP UP TIRES!] ATTENTION'
    elsif tire_pressure > 2.2
      puts "Tire pressure #{self.class}: #{self.tire_pressure}...bad"
      puts 'ATTENTION [!YOU NEED TO FLAT TIRES!] ATTENTION'
    else
      puts "\s\s\sTire pressure #{self.class}: #{self.tire_pressure}...ok"
    end
  end

  def check_fuel_lvl
    if fuel_tank < 25
      puts "\s\s\sFuel level #{self.class}: #{fuel_tank}/100."
      puts "\s\s\sATTENTION [!NEED REFUEL!] ATTENTION"
    else
      puts "\s\s\sFuel level #{self.class}: #{fuel_tank}...ok"
    end
  end

  def fill_tank(level)
    self.fuel_tank = level
  end
end