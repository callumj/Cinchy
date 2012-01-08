module BotPlugins
  class Hello
    include Cinch::Plugin

    match /^hello/
    prefix nil do
    end
  
    help "Says hi to you."
    
    def execute(m)
      m.reply "Hello, #{m.user.nick}"
    end
  end
end