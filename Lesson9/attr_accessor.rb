module AttrAccessorHistory
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history_name = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }
      
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)

        local_history = instance_variable_get(history_name)
        local_history ||= Array.new
        local_history << value
        instance_variable_set(history_name, local_history)
      end
      
      define_method("#{name}_history") { instance_variable_get(history_name) }
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
      
    define_method("#{name}=".to_sym) do |value|
      raise "Type mismatch!" if value.class != class_name
      instance_variable_set(var_name, value)
    end
  end
end

class Test
  extend AttrAccessorHistory

  attr_accessor_with_history :one, :two, :three
  
  strong_attr_accessor :strong_one, Fixnum
end