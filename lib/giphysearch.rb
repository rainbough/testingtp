require 'rubygems'
require 'bundler/setup'
require 'giphy'
require 'json'
require 'net/http'
# require 'pry'

require_relative 'tweetsearch'

module GiphySearch  
  # Take the tweet word from tweetsearch module and search Giphy for a gif.
  class PicSearch    
    attr_accessor :result
    
    def initialize(result)
      @result = result
    end
    
    # Use the provided result from the Twitter Search to search Giphy API. This
    # results in an Array.
    #
    # Select index one and call .id on it to return the 
    # gif id (so the absolute url can be used in telephone.rb to embed gif).
    # 
    # Returns a String.
    def fetch_gif!
      Giphy::Configuration.configure do |config|
        config.api_key = "dc6zaTOxFJmzC" 
      end  
      Giphy.search(@result).first.id
    end
  end
end


