require_relative 'instance_counter.rb'

class Station

  NAME_FORMAT = /^[a-z]{3,15}$/i
  

  include InstanceCounter

  @@all_stations = []

  def self.all
    puts @@all_stations
  end

  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << name
    register_instance
    validate!
  end

  def validate!
    raise "Не введено имя станции" if @name.nil? #лишний метод из-за ArgimentError
    raise "Название должно состоять не менее чем из двух символов" if name.length < 3
    raise "Название может включать не более 15 символов ЛАТИНИЦЫ" if name !~ NAME_FORMAT
    #знаю что не совсем толковый формат просто для тренировки
  def valid?
    validate!
    true
  rescue
    false
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    result = []
    @trains.each { |train| result << train if train.type == type }
    result
  end

  def all_trains_on_station(block)
    self.trains.each {|train| block.call(train)}
  end
end
end

  
  
  



  



  

    
    
