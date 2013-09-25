require 'rubygems'
require 'bundler/setup'
require 'twitter'
require 'json'
# require 'pry'


module TweetSearch
  
  # Takes user input and searches through Twitter API for a tweet .
  class UserWord
    attr_reader :word, :tweet, :result
    
    def initialize(word)
      @word = word
    end
  
    # Fetch a Tweet containing the provided word and select another
    # random word from the Tweet.
    # 
    # From https://github.com/sferik/twitter#configuration
    # 
    # Returns false if the word is not found in a tweet. 
    # 
    # If a tweet is found containing the inputed word, it is sent to select_word method.
    # 
    # Returns the String word 
    def fetch_tweet!
      client = Twitter::Client.new.configure do |config|
        config.consumer_key = ENV['CONSUMER_KEY']
        config.consumer_secret = ENV['CONSUMER_SECRET']
        config.oauth_token = ENV['OAUTH_TOKEN']
        config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
      end

      
      tweets = client.search(@word, :lang => "en", :count => 1).results
      if tweets.empty?
        return false
      else
        @tweet = tweets.first.text
      
        select_word(@tweet)

      end
    end


    # Choose an appropriate word from the tweet.
    #
    # Returns the String newly selected word.
    def select_word(tweet)
      @result = TweetSanitizer.new(tweet).sanitized_words.sample(1)
    end
  end

  # Takes the returned tweet and cleans it up in order to select an appropriate random word.  
  class TweetSanitizer
    
    def initialize(tweet)
      @tweet = tweet
    end

    # Splits the retured tweet into an array of words. 
    # 
    # Returns an Array of words more than 4 characters that only contain letters.
    def sanitized_words
      @words = @tweet.split(" ")

      remove_short_words
      remove_non_alpha_words

      @words
    end



    # Deletes words with less than four characters.
    # 
    # Returns an Array.
    def remove_short_words
      @words = @words.delete_if {|w| w.length < 4}
    end

    # Deletes words that contain anything other than letters.
    def remove_non_alpha_words
      @words.select! {|w| w.match(/^[a-zA-Z]+$/) }
    end
  end
end
