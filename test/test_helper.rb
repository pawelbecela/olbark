require "rubygems"
require "bundler"

require "test/unit"
require "rack/test"

Bundler.require(:default, :test)

require './app'
