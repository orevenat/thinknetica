module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym

      define_method(name) do
        history = instance_variable_get(var_name)
        history.last if history
      end

      define_method("#{name}=".to_sym) do |value|
        prev = instance_variable_get(var_name)
        new_value = prev.nil? ? [value] : [*prev, value]
        instance_variable_set(var_name, new_value)
      end

      define_method("#{name}_history") do
        instance_variable_get(var_name)
      end
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) do
      instance_variable_get(var_name)
    end
    define_method("#{name}=".to_sym) do |value|
      raise 'Wrong class name' if class_name != value.class

      instance_variable_set(var_name, value)
    end
  end
end
