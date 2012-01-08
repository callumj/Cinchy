module BotPlugins
  class Commands
    include Cinch::Plugin

    match "commands"
  
    help "List commands registered on this bot"
    
    def execute(m)
      commands = []
      registered_events = bot.events
      registered_events.each do |event|
        event.each do |inner_event|
          if inner_event.class.eql?(Array)
            inner_event.each do |event_reg|                            
              if event_reg[1].class.eql?(Array) && event_reg[1][0].class.eql?(String)
                help_msg = event_reg[1][0] 
                reg_group = inner_event[inner_event.index(event_reg) - 1]
                
                pattern = reg_group[0][0]
                
                resolve_prefix =  pattern.prefix
                
                prefix = resolve_prefix
                if resolve_prefix.class.eql?(Proc)
                  prefix = resolve_prefix.call()
                elsif resolve_prefix.class.eql?(Regexp)
                  prefix = resolve_prefix.source
                end
                
                cmd = pattern.pattern
                cmd = cmd.source if cmd.class.eql?(Regexp)
                
                cmd.gsub!(/^\^/,"")
                prefix.gsub!(/^\^/,"") unless prefix.nil?
                
                commands << "#{prefix}#{cmd}: #{help_msg}"
              end
            end
          end
        end
      end
      m.reply("This bot responds to")
      commands.each {|cmd| m.reply("  " + cmd)}
    end
  end
end