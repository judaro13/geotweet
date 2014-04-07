class GeoTweetController < ApplicationController

  def index
    #by tags
    #by_tags = Tweet.where(:hashtags.in => params[:tags])
    
    #by_tags and sentiments
    #by_tags_sent = Tweet.where(:hashtags.in => params[:tags], rank: params[:rank])
  end
end
