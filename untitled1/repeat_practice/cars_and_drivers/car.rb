require_relative 'modules'

class Car
  include SystemsCheck

  attr_reader :current_rpm,
              :tire_pressure,
              :fuel_tank
  
  def initialize(options = {})
    @current_rpm = 0
    @tire_pressure = options[:tire_pressure]
    @fuel_tank = options[:fuel_tank]
  end
  
  def start_engine
    start_engine! if engine_stopped?
  end

  def stop_engine
    stop_engine! if start_engine!
  end
  
  def engine_stopped?
    self.current_rpm.zero?
  end

  def fill_tank(level)
    @fuel_tank = level
  end

  def pump_up_tires(bar)
    @tire_pressure = bar
  end

  protected

  attr_writer :current_rpm,
              :tire_pressure,
              :fuel_tank

  STOPPED_ENGINE_RPM = 0

  def initial_rpm
    700
  end

  def start_engine!
    self.current_rpm = initial_rpm
  end

  def stop_engine!
    self.current_rpm = STOPPED_ENGINE_RPM
  end
end





