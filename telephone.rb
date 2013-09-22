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


post '/twitter' do 
@result = TweetSearch::UserWord.new(params[:word]).search![0]
@output_result = GiphySearch::PicSearch.new(@result).post_gif!

#   uri = "http://api.giphy.com/v1/gifs/translate?s=#{@result}&api_key=dc6zaTOxFJmzC&limit=1"
#   resp = Net::HTTP.get_response(URI.parse(url))
#   buffer = resp.body

#   @output_result = "http://giphy.com/gifs/#{id}"
 erb :twitter_results
end 


 



