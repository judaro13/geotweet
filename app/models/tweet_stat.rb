class TweetStat
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Geospatial
  
  field :ranks, type: Hash, default: {}
  field :rank_ling_pipe, type: Hash, default: {}
  field :rank_lexicon, type: Hash, default: {}
  
  
end

