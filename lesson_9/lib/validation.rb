module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, value)
      var_name = "@#{name}".to_sym
    end
  end

  module InstanceMethods
    def validate!
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end
  end
end
