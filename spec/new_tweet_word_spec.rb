require 'rubygems'
require 'bundler'
require 'rspec'
require_relative '../lib/new_tweet_word.rb'

describe TweetSearch::User_word do
  
  describe '#split' do
    it 'should delete all words less than 4 characters and return a random word from a tweet' do
      tweet = double("basketball")
      
      allow(tweet).to receive(:text).and_return("Hello and")

      expect(tweet.text.split).to eq("Hello")
    end
  end
end