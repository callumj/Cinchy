require 'pathname'
require 'uri'
require 'find'
module BotPlugins
  class QuickPlay
    include Cinch::Plugin

    match /play (.+)/
  
    help "Tells the VLC instance to play stuff (immediately)"
    
    def execute(m, params)
      if HelperLib::SharedTelnet.instance(:vlc).nil?
        m.reply("VLC instance not running")
      else
        start_path = HelperLib::SharedObject.instance(:config).music_path
        path = nil
        path = params if (Pathname.new params).absolute?
        path = params unless (/^#{URI::DEFAULT_PARSER.regexp[:ABS_URI]}$/.match(params)).nil?
      
        test_path = "#{start_path}/#{params}"
        if path.nil? && File.exists?(test_path)
          path = test_path
        else
          Find.find(start_path) do |file_path|
            puts file_path
            if file_path.include?(params)
              path = file_path
              break
            end
          end
        end
      
        m.reply("Playing #{path}")
        HelperLib::SharedTelnet.instance(:vlc).command("clear")
        HelperLib::SharedTelnet.instance(:vlc).command("add #{path}")
      end
    end
  end
end
