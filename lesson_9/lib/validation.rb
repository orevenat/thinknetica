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
        value = validate[:value]
        var_value = instance_variable_get(var_name)
        case validate[:type]
        when :presence
          raise 'Must be not empty' if var_value.nil?
        when :format
          raise 'Diffreent format error' if value !~ var_value
        when :type
          raise 'Diffrent type error' if value != var_value.class
        when :length
          raise "Min length is #{value}" if value > var_value.size
        end
      end
    end
  end
end
