require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'twitter'
require_relative 'lib/tweetsearch'


get '/' do 
  erb :index
end

post '/twitter' do 
  @result = TweetSearch::UserWord.new(params[:word]).search!

  erb :something
end
