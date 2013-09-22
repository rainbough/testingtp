require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'twitter'
require 'giphy'
require 'json'
require 'net/http'

require_relative 'lib/tweetsearch.rb'
require_relative 'lib/giphysearch'



get '/' do 
  erb :index
end

# @result is the resulting word from calling .search! method. 
# This is returned from Twitter API as an array, we call the first indexed value.
# is then indexed to the first
# 
# @output_result gives the resulting giphy image id (from giphy url).
# 
# @gif_url is set to the absolute url so that @gif_url can later be 
# passed to bit.ly API. 
post '/twitter' do 
  
  @result = TweetSearch::UserWord.new(params[:word]).search![0]
  @output_result = GiphySearch::PicSearch.new(@result).fetch_gif!
  @gif_url = "http://media.giphy.com/media/#{@output_result}/giphy.gif"
   
  erb :twitter_results
end 


 



