require "open-uri"
require 'open_uri_redirections'
require 'oauth'

require 'rubygems'
require 'json'



tweet_filename = 'USAGov-tweets-page-2.json'
tweets_file = File.open(tweet_filename)
parsed_json= JSON.parse(tweets_file.read)
tweets_file.close


first_tweet = parsed_json[0]
user = first_tweet["user"]

puts user["screen_name"]
puts user["name"]
puts user["created_at"]
puts user["statuses_count"]

puts first_tweet["created_at"]
puts first_tweet["text"]
