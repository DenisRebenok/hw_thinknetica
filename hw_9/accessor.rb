module Accessor
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        variable = "@#{name}".to_sym
        history = "@#{name}_history".to_sym
        define_method(name) { instance_variable_get(variable) }
        define_method("#{name}=") do |value|
          instance_variable_set(variable, value)
          instance_variable_set(history, []) unless instance_variable_defined?(history)
          instance_variable_get(history) << value
        end
      end

      def strong_attr_acessor(attr_name, attr_class)
        raise TypeError, "Accessor name must have symbol value" unless attr_name.is_a?(Symbol)
        var_name = "@#{attr_name}".to_sym
        define_method(attr_name) { instance_variable_get(var_name) }
        define_method("#{attr_name}=") do |value|
          raise TypeError, "#{value} must be #{attr_class}" unless value.is_a?(attr_class)
          instance_variable_set(var_name, value)
        end
      end
    end
  end
end