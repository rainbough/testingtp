require 'rubygems'
require 'bundler/setup'
require 'giphy'
require 'bitly'

module BitlySearch
  # Takes the gif image url and shortens it to a bitly.
  class Bitly
    attr_accessor :gif_url
    def initialize(gif_url)
      @gif_url = gif_url
    end

    # Use the provided gif image url returned from giphy API to generate bitly url. 
    def shorten_url!
      Bitly.configure do |config|
        config.api_version = 3
        config.login = "Bitly_Username"
        config.api_key = "API_KEY"
      end
      Bitly.shorten_url(@gif_url)      
    end
  end
end
