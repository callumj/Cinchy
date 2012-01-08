## Cinchy ##

A bot based on Cinch.rb

#### What? ####

Cinchy is my use of Cinch.rb to create an easier to build IRC bot. To achieve this Cinchy is able to scan the plugins/ directory and preload all plugins that inherit from the BotPlugins module into Cinch.

Cinch also includes a helper !commands that uses a monkey patch Cinch::Bot class to expose the events attribute and list the commands the bot responds to.

It also includes some helpers for interacting with VLC and easily sending files to it from a specific directory.