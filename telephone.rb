require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'twitter'
require 'giphy'
require 'json'
require 'net/http'

require_relative 'lib/tweetsearch'



get '/' do 
  erb :index
end


post '/twitter' do 
 @word = params[:word]
 @output_result = TweetSearch::UserWord.new(@word).search! 
binding.pry
  uri = "http://api.giphy.com/v1/gifs/translate?s=#{@result}&api_key=dc6zaTOxFJmzC&limit=1"

  resp = Net::HTTP.get_response(URI.parse(url))
  buffer = resp.body

  @output_result = "http://giphy.com/gifs/#{id}"
 erb :twitter_results
end 


 



