$:.unshift File.expand_path("./../lib", __FILE__)
require 'bundler'
Bundler.require
require 'app'
require 'sinatra/base'
require 'sinatra/reloader'
require './lib/app'

run IdeaBoxApp