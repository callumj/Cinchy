require 'rubygems'
require 'bundler'
require 'yaml'
require 'json'
Bundler.require(:default)

Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |file| puts "Loading lib #{file}"; load(file) }
Dir["#{File.dirname(__FILE__)}/plugins/**/*.rb"].each { |file| puts "Loading plugin #{file}"; load(file) }

config = YAML::load( File.open("#{File.dirname(__FILE__)}/config.yml") )
HelperLib::SharedObject.new(:config, config.to_ostruct)