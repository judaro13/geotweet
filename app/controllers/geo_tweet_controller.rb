class GeoTweetController < ApplicationController

  def index
    @tags = Tag.where(lang: "en").desc(:counter).limit(10)
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
    @tags = Tag.where(lang: "es").desc(:counter).limit(10)
    
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
    @tags = Tag.where(lang: lang).desc(:counter).limit(10)
    @tweets = collection.where(:hashtags.in => [params[:tag]])
    @tweets_cities = {}
    @tweets.where(:city.ne => nil, :location.ne => nil).only(:city, :location ).group_by(&:city).each do |group|
      @tweets_cities[group.first] ||= {}
      @tweets_cities[group.first]["count"] = group.last.count
      @tweets_cities[group.first]["x"] = group.last.last.location.x
      @tweets_cities[group.first]["y"] = group.last.last.location.y
    end
    @tweets_cities = @tweets_cities.to_json
  end
  
  def search
    @tweets = Set.new
    @count = 0
    
    query = String.new(params[:q])
    
    @lang = params[:stweet].to_a.include?("Esp") || params[:stweet] || request.referrer.include?("colombia") ? "Español" : "Inglés"
    collection = params[:stweet] ||  request.referrer.include?("colombia") ? Stweet : Tweet
    
    regex_users = /(?:\s|^)(?:@(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i
    users = query.scan(regex_users)
    unless users.empty?
      users.flatten!
      users.each do |t|
        query.gsub!("@"+t, "")
      end
      u_query = collection.any_of({:user.name.in =>  Set.new(users.flatten).to_a}, {:user.nickname.in => Set.new(users.flatten).to_a})
      @count += u_query.count
      @tweets.merge( u_query.to_a)
    end    
    
    regex_tag = /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i
    tags = query.scan(regex_tag)
    unless tags.empty?
      tags.flatten!
      tags.each do |t|
        query.gsub!("#"+t, "")
      end
      t_query = collection.where(:hashtags.in => Set.new(tags).to_a)
      @count += t_query.count
      @tweets.merge( t_query.to_a)
    end
    
    unless query.empty?
      w_query = collection.any_of({content: /#{query}/},{text: /#{query}/})
      @count += w_query.count
      @tweets.merge( w_query.to_a)
    end
    @tweets.to_a
  end
end
