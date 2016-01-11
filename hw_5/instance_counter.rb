module InstanceCounter
  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMetods
    protected

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end

  def self.included(base)
    base.extend ClassMethods    
    base.send :include, InstanceMetods
  end
end