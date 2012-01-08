require 'rubygems'
require 'bundler'
require 'yaml'
Bundler.require(:default)

Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |file| puts "Loading lib #{file}"; load(file) }
Dir["#{File.dirname(__FILE__)}/plugins/**/*.rb"].each { |file| puts "Loading plugin #{file}"; load(file) }

all_plugins = BotPlugins.constants.map { |const| eval("BotPlugins::#{const}") }

config = YAML::load( File.open("#{File.dirname(__FILE__)}/config.yml") )

bot = Cinch::Bot.new do
  configure do |c|
    c.server = config["server"]["host"]
    c.channels = config["server"]["channels"]
    c.port = config["server"]["port"]
    c.ssl.use = config["server"]["ssl"]
    c.password = config["server"]["password"]
    
    c.nick = config["identity"]["username"]
    c.username = config["identity"]["nick"]
    
    c.plugins.plugins = all_plugins
  end
  
  on :connect do
    bot.msg "NickServ", "identify #{config["identity"]["nickserv"]}"
  end
end


HelperLib::SharedTelnet.new(:vlc, "localhost", 1234) # connect to VLC
if config["plugins"]["music_path"]
  HelperLib::SharedObject.new(:config, OpenStruct.new(:music_path => config["plugins"]["music_path"]))
end
bot.start