require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'twitter'
require 'giphy'
require 'json'
require 'net/http'
# require 'pry'
# require 'bitly'

require_relative 'lib/tweetsearch.rb'
require_relative 'lib/giphysearch'
require_relative 'lib/bitlysearch.rb'

get '/' do 
  erb :index
end

# @check_result is the resulting word from calling .fetch_tweet! method. 
# If @check_result is not an empty array, it is sent to
# GiphySearch::PicSearch.
# 
# @output_result gives the resulting giphy image id in twitter_results.erb.
# 
# Otherwise, @output_result is set to nil. This creates a 
# "Try Again" option in twitter_results.erb. 

post '/twitter' do 
  @user_word = params[:word]
  @check_result = TweetSearch::UserWord.new(@user_word).fetch_tweet!

  if @check_result
    @tweet_id = @check_result[1].id  
    @twitter_word = @check_result[0]
    @giphy_id = GiphySearch::PicSearch.new(@twitter_word).fetch_gif!
    
  else 
    @giphy_id = "PPIusDh8elXJS"
  end

  redirect "/twitter_trail?giphy_id=#{@giphy_id}&tweet_id=#{@tweet_id}&twitter_word=#{@twitter_word}"
  erb :twitter_results
end 

# When the redirect happens, the instance variables are reset. 
# 
# Reset instance variables using params from redirect url. These get called in twitter_trail.erb.
get "/twitter_trail" do
  @tweet_id = params[:tweet_id]
  @giphy_id = params[:giphy_id]
  @twitter_word = params[:twitter_word]
  # @bitly = BitlySearch::Bitly.new("/twitter_trail?giphy_id=#{@giphy_id}&tweet_id=#{@tweet_id}&twitter_word=#{@twitter_word}").shorten_url 
  
  erb :twitter_results
end


 



