class GeoTweetController < ApplicationController

  def index
    #by tags
    @tags = Tag.all.desc(:counter).limit(10)
    
    @tweets_cities = {}
    Tweet.where(:city.ne => nil).only(:city, :location).group_by(&:city).each do |group|
      @tweets_cities[group.first] ||= {}
      @tweets_cities[group.first]["count"] = group.last.count
      @tweets_cities[group.first]["x"] = group.last.last.location.x
      @tweets_cities[group.first]["y"] = group.last.last.location.y
    end
    @tweets_cities = @tweets_cities.to_json
    #     binding.pry
    #by_tags and sentiments
    #by_tags_sent = Tweet.where(:hashtags.in => params[:tags], rank: params[:rank])
  end
  
  def spanish_tweets
    @tags = Tag.all.desc(:counter).limit(10)
  end
  
  def by_tag
    @tags = Tag.all.desc(:counter).limit(10)
    @tweets = Tweet.where(:hashtags.in => [params[:tag]])
    @tweets_cities = {}
    Tweet.where(:city.ne => nil, :hashtags.in => [params[:tag]]).only(:city, :location, :hashtags ).group_by(&:city).each do |group|
      @tweets_cities[group.first] ||= {}
      @tweets_cities[group.first]["count"] = group.last.count
      @tweets_cities[group.first]["x"] = group.last.last.location.x
      @tweets_cities[group.first]["y"] = group.last.last.location.y
    end
    @tweets_cities = @tweets_cities.to_json
  end
end
