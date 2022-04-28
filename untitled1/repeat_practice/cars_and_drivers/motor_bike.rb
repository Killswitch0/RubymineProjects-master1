require_relative 'modules'

class MotorBike
  include Engine
end

bike = MotorBike.new
bike.fill_tank(100)
puts bike.fuel_level