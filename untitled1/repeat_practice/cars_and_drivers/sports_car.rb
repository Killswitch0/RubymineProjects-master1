class SportsCar < Car
  def start_engine
    puts 'Click!'
    puts 'Wrumm!!!'

    super
  end

  protected

  def initial_rpm
    1000
  end
end