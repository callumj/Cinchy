module BotPlugins
  class InstanceMethods
    include Cinch::Plugin

    match /^(\w+)[.]rb/
    prefix nil do
    end
  
    help "List the instance methods for a Ruby class"
    
    def execute(m, params)
      the_class = eval(params.capitalize) rescue nil # capitalize to avoid h4x0ring
      unless the_class.nil?
        m.reply the_class.instance_methods - Object.instance_methods
      end
    end
  end
end