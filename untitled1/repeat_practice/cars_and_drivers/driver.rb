class Driver
  def drive(car)
    puts "#{self.class} sat in the car, i turn on #{car.class}..."
    car.start_engine
    check_system_info(car)
  end

  def check_system_info(car)
    puts "\t*INFORMATION TABLE*"
    car.check_tires
    car.check_fuel_lvl
  end
end