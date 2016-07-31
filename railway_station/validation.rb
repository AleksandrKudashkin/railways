module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(parameter, validation_type, *options)
      class_variable_set(:@@validations, Array.new) unless class_variable_defined?(:@@validations)
      def register_validation(name_of_the_method)
        validation_methods = class_variable_get(:@@validations)
        validation_methods << name_of_the_method
        class_variable_set(:@@validations, validation_methods)
      end

      case validation_type
      when :presence
        name_of_the_method = "validation_presence_of_#{parameter}".to_sym
        define_method(name_of_the_method) do
          var_name = instance_variable_get("@#{parameter}".to_sym)
          (var_name.nil? || var_name == '')? false : true
        end
        register_validation(name_of_the_method)
      when :type
        name_of_the_method = "validation_type_of_#{parameter}".to_sym
        define_method(name_of_the_method) do
          var_name = instance_variable_get("@#{parameter}".to_sym)
          (var_name.class != options.first)? false : true
        end
        register_validation(name_of_the_method)
      when :format
        name_of_the_method = "validation_format_of_#{parameter}".to_sym
        define_method(name_of_the_method) do
          var_name = instance_variable_get("@#{parameter}".to_sym)
          (var_name !~ options.first)? false : true
        end
        register_validation(name_of_the_method)
      end
    end
  end

  module InstanceMethods
    def validate!
      validation_methods = self.class.class_variable_get(:@@validations)
      validation_methods.each do |v|
        raise RuntimeError, "#{v.to_s.gsub('_',' ').capitalize} FAILED" unless self.send(v)
      end
      return true
    end

    def valid?
      begin 
        validate!
      rescue
        false
      end
    end
  end
end