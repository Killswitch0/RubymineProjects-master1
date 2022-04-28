require_relative 'car'
require_relative 'truck'
require_relative 'sports_car'
require_relative 'driver'


car = Car.new
car.start_engine
puts car.check_rpm

puts

truck = Truck.new
truck.start_engine
puts truck.check_rpm

puts

sports_car = SportsCar.new(tire_pressure: 2.2, fuel_tank: 24)
sports_car.start_engine
puts sports_car.check_rpm
sports_car.check_tires
sports_car.check_fuel_lvl

puts

driver = Driver.new
driver.drive(sports_car)
sports_car.fill_tank(100)
driver.drive(sports_car)

puts

sports_car.pump_up_tires(3.0)
driver.drive(sports_car)





