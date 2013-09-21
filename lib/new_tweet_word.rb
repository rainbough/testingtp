require 'rubygems'
require 'bundler/setup'
require 'twitter'

module TweetSearch

  class User_word
    attr_reader :word
    
    def initialize(word)
      @word=word
    end
  
    # This will authenticate us to search twitter. 
    def tweet_auth
      client = Twitter::Client.new.configure do |config|
        config.consumer_key = ENV['CONSUMER_KEY']
        config.consumer_secret = ENV['CONSUMER_SECRET']
        config.oauth_token = ENV['OAUTH_TOKEN']
        config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
      end
      # From https://github.com/sferik/twitter#configuration
      # 
      # searches through Twitter client to find the word from html form. Will only return the first tweet.
      new_tweet = client.search(@word, :count => 1).results.first.text
    end

    # Takes the tweet returned by seaching through Twitter api and deletes words shorter than 4 characters. The split method returns as array.
    # 
    # Calling .sample on the new_tweet array returns one random word. 
    
    def split
      new_tweet.split(" ").delete_if {|w| w.length < 4}
      new_word = new_tweet.sample(1)
    end
  end
end