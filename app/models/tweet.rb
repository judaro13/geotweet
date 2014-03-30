class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Geospatial
  
  field :tweet_id, type: String
  field :pub_date, type: DateTime
  field :content,  type: String
  
  field :location, type: Point
  spatial_index :location
  
  before_save :set_tweet_location
  
  def set_tweet_location
  end
  
end

