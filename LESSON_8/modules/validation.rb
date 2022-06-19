module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    @@arr = []
    def validate(*args)
      @@arr.push(args)
      class_variable_set(:@@args, @@arr)
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue
      false
    end

    protected

    def validate!
      self.class.class_variable_get(:@@args).each do |array|
        name = "@#{array[0]}".to_sym
        type = array[1].to_s
        param = array[2] unless array[2].nil?

        case type
        when 'presence'
          raise "Значение не должно быть пустым!" if
            instance_variable_get(name) == nil ||
            instance_variable_get(name) == ''

        when 'format'
          raise "Неправильный формат" if instance_variable_get(name) !~ param

        when 'type'
          raise "Неверный тип данных, должен быть #{param}" if instance_variable_get(name).class != param
        end
      end
    end
  end
end
