require 'rubygems'
require 'bundler/setup'
require 'giphy'
require 'pry'

require_relative 'tweetsearch'

module GiphySearch  
  # Take the tweet word from tweetsearch module and search Giphy for a gif.
  class PicSearch    
    attr_accessor :result
    def initialize(result)
      @result = result
    end
    # Fetch a gif from Giphy with the provided result from the Twitter Search.
    #
    # Returns the first matching Giphy::Gif
    def search!
      client = Giphy::Configuration.configure do |config|
      # config.version = ""
      config.api_key = "dc6zaTOxFJmzC" 
      end  
binding.pry
      @pic = client.search(@result, {limit:1})
    end
  end
end



