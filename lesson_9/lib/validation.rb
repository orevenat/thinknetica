module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validates

    def validate(name, type, value = '')
      self.validates ||= []
      self.validates << { name: name, type: type, value: value }
    end

    protected

    def validate_presence(val, _empty)
      raise 'Must be not empty' if val.nil?
    end

    def validate_format(val, format)
      raise 'Diffreent format error' if format !~ val
    end

    def validate_type(val, type)
      raise 'Diffrent type error' if type != val.class
    end

    def validate_length(val, length)
      raise "Min length is #{value}" if length > val.size
    end

    attr_writer :validates
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    protected

    def validate!
      self.class.validates.each do |validate|
        var_name = "@#{validate[:name]}".to_sym
        instance_value = instance_variable_get(var_name)
        value = validate[:value]
        type = validate[:type]
        self.class.send "validate_#{type}".to_sym, instance_value, *value
      end
    end
  end
end
