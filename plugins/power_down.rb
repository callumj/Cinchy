module BotPlugins
  class PowerDown
    include Cinch::Plugin

    match "power down"
  
    help "Kill the bot"
    
    def execute(m)
      bot.quit("I was told to leave")
    end
  end
end
