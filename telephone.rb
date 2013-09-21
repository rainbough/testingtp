require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'twitter'
require_relative 'lib/tweetsearch'


get '/' do 
  erb :index
end

get '/twitter' do 
  @word = params[:word]
  @output_result = TweetSearch::UserWord.new(@word).search!
end

post '/twitter' do 
  @real
  erb :twitter_results
end
