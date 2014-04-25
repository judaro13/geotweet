class Stweet
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Geospatial
  
  field :tweet_id, type: String
  field :pub_date, type: DateTime
  field :text,  type: String
  field :ranks, type: Hash, default: {}
  field :rank, type: Integer
  field :hashtags, type: Array, default: []
  field :rank_lexicon
  field :rank_total_lexicon, type: Integer
  field :rank_me, type: Integer
  field :rank_nlp, type: Integer
  
  
  field :city, type: String
  field :department, type: String
  field :col_location, type: Hash, default: {}
  field :location, type: Point
  
  belongs_to :user
  
  spatial_index :location
  
  before_save :set_totals
  before_save :set_location
  before_save :set_tweet_hashtags
  
  def content
    self.text
  end
  
  def set_totals
    self.rank_total_lexicon = self.rank_lexicon if self.rank_lexicon.kind_of?(Integer)
    self.rank_total_lexicon = self.rank_lexicon.first["total"] if self.rank_lexicon.kind_of?(Array)
  end
  
  def set_location
     if col_location && col_location.kind_of?(Hash) && !col_location.empty?
       self.location = [self.col_location["lat"], self.col_location["lon"]]
     else
       self.location = nil
     end
  end
  
  def set_tweet_hashtags
    regex = /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i
    hashtags = self.text.scan(regex)
    unless hashtags.empty?
      self.hashtags = Set.new(hashtags.flatten).to_a
      self.hashtags.each do |t|
       tag = Tag.where(name: t).first
        unless tag
          tag = Tag.new
          tag.name = t
        end
        
        tag.rank_lexicon[self.rank_total_lexicon.to_s] ||= 0 if self.rank_total_lexicon
        tag.rank_lexicon[self.rank_total_lexicon.to_s] += 1 if self.rank_total_lexicon
        
        tag.rank_me[self.rank_me.to_s] ||= 0 if self.rank_me
        tag.rank_me[self.rank_me.to_s] += 1 if self.rank_me
        
        tag.rank_nlp[self.rank_nlp.to_s] ||= 0 if self.rank_nlp
        tag.rank_nlp[self.rank_nlp.to_s] += 1 if self.rank_nlp
        
        tag.lang = "es"
        tag.up_counter
      end
    end
  end
   
end

