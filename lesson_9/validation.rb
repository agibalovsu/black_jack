# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(attr_name, validation_type, arg = nil)
      validations << { attr_name: attr_name, validation_type: validation_type, arg: arg }
    end
  end

  module InstanceMethods
    def validate!
      errors = []

      self.class.validations.each do |validation|
        action = "#{validation[:validation_type]}_validation".to_sym
        message = send(action, validation[:attr_name], validation[:arg])
        errors << message unless message.nil?
      end

      raise errors.join('; ') unless errors.empty?
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    private

    def attr_value(attr_name)
      instance_variable_get("@#{attr_name}".to_sym)
    end

    def presence_validation(attr_name, _)
      'Пустое значение атрибута' if attr_value(attr_name).nil? && attr_value(attr_name).empty?
    end

    def format_validation(attr_name, format)
      'Неверный формат имени' if attr_value(attr_name) !~ format
    end

    def type_validation(attr_name, type)
      'Неверный тип объекта' unless attr_value(attr_name).kind_of? type
    end
  end
end
