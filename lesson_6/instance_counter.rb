module InstanceCounter
  
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    attr_accessor :count_instances 

    def instances
      if count_instances == nil
        return 0 # убрал puts
      else
        count_instances
      end
    end

  end

  module InstanceMethods

    protected

    def register_instance
      self.class.count_instances ||= 0 # @count_instances ||= 0 не считает экземпляры класса
      self.class.count_instances += 1
    end
  end
end