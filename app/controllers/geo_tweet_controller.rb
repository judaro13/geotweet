class GeoTweetController < ApplicationController

  def index
    @tags = Tag.where(:rank_lexicon.ne => {}, lang: "en").desc(:counter).limit(10)
    
    @tweets_cities = {}
    Tweet.where(:city.ne => nil).only(:city, :location).group_by(&:city).each do |group|
      @tweets_cities[group.first] ||= {}
      @tweets_cities[group.first]["count"] = group.last.count
      @tweets_cities[group.first]["x"] = group.last.last.location.x
      @tweets_cities[group.first]["y"] = group.last.last.location.y
    end
    @tweets_cities = @tweets_cities.to_json
  end
  
  def spanish_tweets
    @tags = Tag.where(:rank_lexicon.ne => {}, lang: "es").desc(:counter).limit(10)
    
    @tweets_cities = {}
    Stweet.where(:location.ne => nil).only(:city, :department, :location).group_by(&:city).each do |group|
      @tweets_cities[group.first] ||= {}
      @tweets_cities[group.first]["count"] = group.last.count
      @tweets_cities[group.first]["x"] = group.last.last.location.x
      @tweets_cities[group.first]["y"] = group.last.last.location.y
    end
    @tweets_cities = @tweets_cities.to_json
  end
  
  def by_tag
    lang = params[:stweet] ? "es" : "en"
    collection = params[:stweet] ? Stweet : Tweet
    @tags = Tag.where(:rank_lexicon.ne => {}, lang: lang).desc(:counter).limit(10)
    @tweets = collection.where(:hashtags.in => [params[:tag]])
    @tweets_cities = {}
    @tweets.where(:city.ne => nil).only(:city, :location ).group_by(&:city).each do |group|
      @tweets_cities[group.first] ||= {}
      @tweets_cities[group.first]["count"] = group.last.count
      @tweets_cities[group.first]["x"] = group.last.last.location.x
      @tweets_cities[group.first]["y"] = group.last.last.location.y
    end
    @tweets_cities = @tweets_cities.to_json
  end
  
  def search
    
  end
end
