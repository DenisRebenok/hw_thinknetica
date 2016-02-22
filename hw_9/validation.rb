module Validation
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods
  end

  MESSAGES =  
  { presence: "can't be blank!", format: "has wrong format!", type: "has invalid type!" }

  module ClassMethods
    def validate(attr_name, validation_type, *args)
      @validations ||= {}
      @validations[attr_name] = { validation_type: validation_type, param: args.first }
      define_method("validations") { self.class.instance_variable_get("@validations") }
      define_method("attr_value") { |name| instance_variable_get("@#{name}") }
    end

    private

    attr_reader :validations
  end

  module InstanceMethods
    def validate!
      validations.each do |attr_name, args|
        validation_type = args[:validation_type]
        validation_param = args[:param]
        error = send("#{validation_type}", attr_name, validation_param)
        raise ArgumentError, error_msg(attr_name, validation_type, validation_param) if error
      end
      true
    end

    def valid?
      validate!
    rescue ArgumentError
      false
    end

    def valid_argument_type?(argument, appropriate_type)
      if argument.class != appropriate_type
        fail ArgumentError, 'Unsupported type. Must be a #{appropriate_type} object!'
      else
        true
      end
    rescue ArgumentError
      false
    end

    private

    def presence(attr_name, param = nil)
      attr_value(attr_name).nil? || attr_value(attr_name).to_s.empty?
    end

    def format(attr_name, format)
      attr_value(attr_name) !~ format
    end

    def type(attr_name, type)
      attr_value(attr_name).class != type
    end

    def error_msg(attr_name, validation_type, param = nil)
      msg = "#{attr_name} #{Validation::MESSAGES[validation_type]}"
      return msg unless param
      msg += if validation_type == :type
              " Must be an instance of #{param} class!"
        elsif validation_type == :format
              " Must have #{param.source} format!"
        end
    end
  end
end
