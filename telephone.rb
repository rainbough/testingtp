require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'twitter'
require 'giphy'
require 'json'
require 'net/http'
require 'pry'

require_relative 'lib/tweetsearch.rb'
require_relative 'lib/giphysearch'


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
  
  @check_result = TweetSearch::UserWord.new(params[:word]).fetch_tweet!

  tweet_id = @check_result[1].id
  twitter_word = @check_result[0]
  

  if @check_result
    @giffy_id = GiphySearch::PicSearch.new(twitter_word).fetch_gif!
    @gif_url = "http://media.giphy.com/media/#{@giffy_id}/giphy.gif"
  else 
    @output_result = nil
  end

  redirect "/twitter_trail?giffy_id=#{@giffy_id}&tweet_id=#{tweet_id}&twitter_word=#{twitter_word}"
  #erb :twitter_results
end 

get "/twitter_trail" do
  @params = params
  erb :twitter_trail
end


 



