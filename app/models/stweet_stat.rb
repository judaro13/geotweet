class StweetStat
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ranks, type: Hash, default: {}
  field :rank_lexicon, type: Hash, default: {}
  
  
end

