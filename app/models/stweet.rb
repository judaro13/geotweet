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
  field :rank_lexicon, type: Hash, default: {}
  field :rank_total_lexicon, type: Integer
  
  field :city, type: String
  field :location, type: Point
  
  belongs_to :user
  
  spatial_index :location
  
#   before_save :set_tweet_location
  before_save :set_tweet_hashtags
  

  CITIES = ['Bogotá','Bogota''Medellín','Medellin','Cali','Barranquilla','Cartagena','Cúcuta','Cucuta','Soledad','Bucaramanga','Soacha','Santa Marta', 'Villavicencio', 'Pereira', 'Bello', 'Valledupar', 'Montería', 'Monteria', 'Pasto', 'Manizales', 'Buenaventura', 'Neiva', 'Palmira', 'Armenia', 'Popayán', 'Popayan', 'Sincelejo', 'Itagui', 'Floridablanca', 'Riohacha', 'Envigado', 'Tuluá', 'Tuluá'].uniq(&:downcase).sort_by(&:downcase)
  
  def content
    self.text
  end
  
  def set_tweet_location
    unless  self.city
      regex = /\b#{ Regexp.union(CITIES) }\b/i
      cities = self.text.scan(regex)
      if city = cities.first
        self.city = city
        begin
          self.location = Geocoder.search(city+", Colombia").first.coordinates
        rescue
          self.city = nil
        end
      end
    end
    self.rank_total_lexicon = self.rank_lexicon.first["total"].to_i if self.rank_lexicon.first
  end
  
  def set_tweet_hashtags
    regex = /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i
    hashtags = self.text.scan(regex)
    unless hashtags.empty?
      self.hashtags = Set.new(hashtags.flatten).to_a
      self.hashtags.each do |t|
        if tag = Tag.where(name: t).first
          tag.lang = "es"
          tag.up_counter
        else
          tag = Tag.new
          tag.name = t
          tag.lang = "es"
          tag.save
        end
      end
    end
  end
   
end

