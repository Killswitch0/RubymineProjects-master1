module Engine
end

module SystemsCheck
  def check_rpm
    "Текущие обороты двигателя #{self.class}: #{self.current_rpm}"
  end

  def check_tires
    if self.tire_pressure < 2.2
      puts "Tire pressure #{self.class}: #{self.tire_pressure}...bad"
      puts 'ATTENTION [!YOU NEED TO PUMP UP TIRES!] ATTENTION'
    elsif self.tire_pressure > 2.2
      puts "Tire pressure #{self.class}: #{self.tire_pressure}...bad"
      puts 'ATTENTION [!YOU NEED TO FLAT TIRES!] ATTENTION'
    else
      puts "\s\s\sTire pressure #{self.class}: #{self.tire_pressure}...ok"
    end
  end

  def check_fuel_lvl
    if self.fuel_tank < 25
      puts "\s\s\sFuel level #{self.class}: #{self.fuel_tank}/100."
      puts "\s\s\sATTENTION [!NEED REFUEL!] ATTENTION"
    else
      puts "\s\s\sFuel level #{self.class}: #{self.fuel_tank}...ok"
    end
  end
end