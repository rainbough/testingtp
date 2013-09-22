require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'twitter'

require_relative 'lib/tweetsearch'
require_relative 'lib/giphysearch'


get '/' do 

  erb :index
end

post '/twitter' do 
  @word = params[:word]
 TweetSearch::UserWord.new(@word).search!
 @output_result = GiphySearch::PicSearch.new(@result).search!
 erb :twitter_results
end


