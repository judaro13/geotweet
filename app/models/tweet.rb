class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Geospatial
  
  field :tweet_id, type: String
  field :pub_date, type: DateTime
  field :content,  type: String
  field :ranks, type: Hash, default: {}
  field :rank, type: Integer
  field :rank_ling_pipe, type: Hash
  field :rank_total_ling_pipe
  field :rank_lexicon, type: Hash, default: {}
  field :rank_total_lexicon
  field :hashtags, type: Array, default: []
  
  field :city, type: String
  field :location, type: Point
  
  belongs_to :user
  
  spatial_index :location
  
#   before_save :set_tweet_location
  before_save :set_tweet_hashtags
  
  def set_tweet_location
    regex = /\b#{ Regexp.union(CITIES) }\b/i
    cities = self.content.scan(regex)
    if city = cities.first
      self.city = city
      self.location = Geocoder.search(city).first.coordinates
    end
  end
  
  def set_tweet_hashtags
    regex = /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i
    hashtags = self.content.scan(regex)
    unless hashtags.empty?
      Set.new(hashtags.flatten).to_a.each do |t|
        tag = Tag.where(name: t).first
        unless tag
          tag = Tag.new
          tag.name = t
        end
        
        tag.lang = "en"
        
        tag.rank_lexicon[self.rank_total_lexicon.to_s] ||= 0 if self.rank_total_lexicon
        tag.rank_lexicon[self.rank_total_lexicon.to_s] += 1 if self.rank_total_lexicon
        
        tag.rank[self.rank.to_s] ||= 0 if self.rank
        tag.rank[self.rank.to_s] += 1 if self.rank
        
        tag.rank_ling_pipe[self.rank_total_ling_pipe.to_s] ||= 0 if self.rank_total_ling_pipe
        tag.rank_ling_pipe[self.rank_total_ling_pipe.to_s] += 1 if self.rank_total_ling_pipe
        
        tag.up_counter
      end
    end
  end
   
end

