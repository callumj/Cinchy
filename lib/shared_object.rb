require 'net/telnet'

module HelperLib
  class SharedObject
    @@instances = {}
    
    attr_accessor :session
    
    def self.instance(id)
     @@instances[id.to_sym]
    end
    
    def initialize(id, object)
      @@instances[id.to_sym] = object
    end
  end
end