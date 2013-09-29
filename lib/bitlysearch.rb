require 'rubygems'
require 'bundler/setup'
require 'giphy'
require 'bitly'

module BitlySearch
  # Takes the gif image url and shortens it to a bitly.
  class Bitly
    attr_accessor :url
    def initialize(url)
      @url = url       
      
    end

    # Use the provided gif image url returned from giphy API to generate bitly url. 
    def shorten_url
    

      Bitly.configure do |config|
        config.api_version = 3
        config.login = ENV['USERNAME']
        config.api_key = ENV ['KEY']
      end
      bitly.shorten(@url)      
    end
  end
end
