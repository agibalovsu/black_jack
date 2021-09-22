# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*methods)
      methods.each do |method|
        send(:attr_reader, method.to_sym, "#{method}_history".to_sym)
        define_method("#{method}=".to_sym) do |value|
          instance_variable_set("@#{method}".to_sym, value)
          history_var = "@#{method}_history".to_sym
          instance_variable_get(history_var) || instance_variable_set(history_var, [])
          instance_variable_get(history_var).push(instance_variable_get("@#{method}".to_sym))
        end
      end
    end

    def strong_attr_accessor(method, type)
      send(:attr_reader, method.to_sym, "#{method}_type".to_sym)
      instance_variable_set("@#{method}_type".to_sym, type)
      method_type = instance_variable_get("@#{method}_type".to_sym)
      define_method("#{method}=".to_sym) do |value|
        value.kind_of? method_type ? instance_variable_set("@#{method}".to_sym, value) : raise('Неверный тип метода')
      end
    end
  end
end
