module BotPlugins
  class VLC
    include Cinch::Plugin

    match /vlc (.+)/
  
    help "Controls a VLC instance"
    
    def execute(m, params)
      if HelperLib::SharedTelnet.instance(:vlc).nil?
        m.reply("VLC instance not running")
      else
        HelperLib::SharedTelnet.instance(:vlc).command(params)
      end
    end
  end
end
