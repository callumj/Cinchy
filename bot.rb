load "#{File.dirname(__FILE__)}/bootstrap.rb"

all_plugins = BotPlugins.constants.map { |const| eval("BotPlugins::#{const}") }

config = HelperLib::SharedObject.instance(:config)

bot = Cinch::Bot.new do
  configure do |c|
    c.server = config.server.host
    c.channels = config.server.channels
    c.port = config.server.port
    c.ssl.use = config.server.ssl
    c.password = config.server.password
    
    c.nick = config.identity.username
    c.username = config.identity.nick
    
    c.plugins.plugins = all_plugins
  end
  
  on :connect do
    bot.msg "NickServ", "identify #{config.identity.nickserv}"
  end
end

HelperLib::SharedTelnet.new(:vlc, config.plugins.vlc.host, config.plugins.vlc.port) # connect to VLC
bot.start