module Acсessors
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        val = "@#{name}_values".to_sym
        var = "@#{name}".to_sym
        values = []
        define_method(name) { instance_variable_get(var) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var, value)
          values.push(value)
          instance_variable_set(val, values)
        end
        define_method("#{name}_history") { instance_variable_get(val) }
      end
    end
  end

  module InstanceMethods
    def strong_attr_accessor(name, klass)
      var = "@#{name}".to_sym
      define_singleton_method(name) { instance_variable_get(var) }
      define_singleton_method("#{name}=".to_sym) do |value|
        instance_variable_set(var, value)
        raise "Неверный класс" unless value.class == klass
      end
    end
  end
end

