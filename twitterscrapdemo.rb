require "open-uri"
require 'open_uri_redirections'
require 'oauth'

first_page = 1
last_page = 5

def prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new("APIKEY", "APISECRET", { :site => "https://api.twitter.com", :allow_redirections => :safe, :scheme => :header })

    # now create the access token object from passed values
    token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

    return access_token
end

# Exchange our oauth_token and oauth_token secret for the AccessToken instance.
access_token = prepare_access_token("ACCESS_TOKEN", "ACCESS_SECRET")

# use the access token as an agent to get the home timeline
response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json")


remote_url = "https://api.twitter.com/1.1/statuses/user_timeline.json?count=100&screen_name="
screen_name = "USAGov"

remote_full_url = remote_url + screen_name

(first_page..last_page).each do |page_num|
  response = access_token.get(remote_url + screen_name + "&page=" + page_num.to_s)

  tweets = response.body

  my_local_filename = screen_name + "-tweets-page-" + page_num.to_s + ".json"

  my_local_file = open(my_local_filename, "w")
        my_local_file.write(tweets)

  my_local_file.close

  sleep 5

end
