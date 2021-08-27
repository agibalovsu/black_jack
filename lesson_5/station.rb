require_relative 'instance_counter.rb'

class Station

  include InstanceCounter

  @@all_stations = []

  def self.all
    puts @@all_stations
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << name
    register_instance
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
end
  
  
  
  



  



  

    
    
