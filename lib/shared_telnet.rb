require 'net/telnet'

module HelperLib
  class SharedTelnet
    @@instances = {}
    
    attr_accessor :session
    
    def self.instance(id)
     @@instances[id.to_sym]
    end
    
    def initialize(id, host, port)
      @session = Net::Telnet::new("Host" => host, "Port" => port) rescue nil
      
      @@instances = {} if @@instances.nil?
      @@instances[id.to_sym] = self unless self.session.nil?
    end
    
    def command(msg)
      @session.cmd(msg)
    end
  end
end