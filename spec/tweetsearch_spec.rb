require 'rubygems'
require 'bundler'
require 'rspec'
require_relative '../lib/tweetsearch.rb'

describe TweetSearch::UserWord do
  let(:user_word) { TweetSearch::UserWord.new('foo') }

  before(:each) do
    @random_word = 'cup'

    # Ensure that we always return the same 'random' word.
    sanitized_words = double("sanitized_words")
    sanitized_words.stub(:sample).and_return @random_word
    TweetSearch::TweetSanitizer.stub_chain(:new, :sanitized_words).and_return sanitized_words

    # Don't actually connect to the Twitter API.
    Twitter::Client.stub_chain(:new, :configure, :search)
  end
  context 'word is found in Twitter API' do
    describe '#search!' do
      it 'should return a random word from a tweet' do
        user_word.search!

        expect(user_word.result).to eq(@random_word)
      end
    end
  end

   context 'word is not found in Twitter API' do
    describe '#search!' do
      it 'should return false' do
        @random_word = 'jfdkfhdjh'
        user_word.search!

        expect(user_word.result).to eq(false)
      end
    end
  end
end

describe TweetSearch::TweetSanitizer do
  let(:tweet_sanitizer) do
    tweet = double("tweet")
    tweet.stub(:text).and_return @tweet_text

    TweetSearch::TweetSanitizer.new tweet
  end

  context 'when there are words less than four characters long' do
    before(:each) do
      @tweet_text = 'I have lots of words.'
    end

    it 'returns an array with those words removed' do
      expect(tweet_sanitizer.sanitized_words).to_not include('I')
      expect(tweet_sanitizer.sanitized_words).to_not include('of')
    end
  end

  context 'when there are hashtags' do
    before(:each) do 
      @tweet_text = "#hackathon We're at a hackathon."
    end

    it 'returns an array with those words removed' do 
      expect(tweet_sanitizer.sanitized_words).to_not include('#hackathon')
    end
  end
end