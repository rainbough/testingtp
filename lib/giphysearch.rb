require 'rubygems'
require 'bundler/setup'
require 'giphy'

require_relative 'tweetsearch'

module GiphySearch  
  # Take the tweet word from tweetsearch module and search Giphy for a gif.
  class PicSearch    
    attr_accessor :result
    
    # Fetch a gif from Giphy with the provided result from the Twitter Search.
    #
    # Returns the first matching Giphy::Gif
    def search!
      client = Giphy::Configuration.configure do |config|
      config.version = THE_API_VERSION
      config.api_key = YOUR_API_KEY  
      end  
      @pic = client.search(@result, {limit:1})
    end
  end
end



