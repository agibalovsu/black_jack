# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :count_instances

    def instances
      if count_instances.nil?
        0 # delete puts
      else
        count_instances
      end
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.count_instances ||= 0 # @count_instances ||= 0 not found class instances
      self.class.count_instances += 1
    end
  end
end
