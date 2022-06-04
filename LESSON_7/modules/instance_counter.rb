module InstanceCounter
  def self.included(base) 
    base.extend ClassMethods
    base.include InstanceMethods
    base.class_variable_set('@@instances', 0)
  end

  module ClassMethods
    def instances
      class_variable_get('@@instances')
    end
  end

  module InstanceMethods
    private
    
    def register_instance
      new = self.class.class_variable_get('@@instances') + 1
      self.class.class_variable_set('@@instances', new)
    end
  end
end
