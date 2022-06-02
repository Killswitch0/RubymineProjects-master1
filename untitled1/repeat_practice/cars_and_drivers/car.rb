require_relative 'modules'

class Car
  include SystemsCheck
  include Debugger

  attr_reader :current_rpm,
              :tire_pressure,
              :fuel_tank

  attr_accessor :number

  NUMBER_FORMAT = /^[A-Z]{2}\d{4}[A-Z]{2}$/

  @@instances = 0

  def initialize(options = {})
    @current_rpm = 0
    @tire_pressure = options[:tire_pressure]
    @fuel_tank = options[:fuel_tank]
    @number = options[:number]

    @@instances += 1

    self.class.debug 'initialize'
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  debug 'START INTERFACE!!!'

  def self.all_objects
    puts @@instances
  end

  def fasten_seat_belt
    puts 'PI-PI: FASTEN YOUR SEAT BELT' if engine_stopped? == false
  end

  debug 'END INTERFACE!!!'

  def start_engine
    start_engine! if engine_stopped?
  end

  def stop_engine
    stop_engine! if start_engine!
  end

  def engine_stopped?
    self.current_rpm.zero?
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

  def validate! # Ruby bang method
    raise "Number can't be nil" if number.nil?
    raise 'Number should be at least 6 symbols' if number.length < 6
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
    true
  end
end





