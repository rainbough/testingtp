require 'rubygems'
require 'bundler/setup'
require 'giphy'
require 'pry'
require 'json'
require 'net/http'


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
    
    # def search_giphy!
    #   # search_giphy = JSON.generate[@result[0]]
    #   search_word = @result.to_s
    #   url = URI http://api.giphy.com/v1/gifs/search?q={search_word, limit:1}&api_key=dc6zaTOxFJmzC
    #   response = Net::HTTP.get_response(URI.parse(url))
    #   buffer = res.body
    #   id = JSON.parse(buffer)["data"]["id"]
    #   "http://giphy.com/gifs/#{id}"
    # end

    def post_gif!
     Giphy::Configuration.configure do |config|
      # config.version = ""
      config.api_key = "dc6zaTOxFJmzC" 
      end  
     giphy_array = Giphy.search(@result)
     giphy_first_result = giphy_array[0]
     pic = giphy_first_result.url
    end
  end
end



