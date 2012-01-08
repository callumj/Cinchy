module BotPlugins
  class VLC
    include Cinch::Plugin

    match /vlc (.+)/
  
    help "Controls a VLC instance"
    
    def execute(m, params)
      HelperLib::SharedTelnet.instance(:vlc).command(params)
    end
  end
end
