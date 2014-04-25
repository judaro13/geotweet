class StweetStat
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ranks, type: Hash, default: {}
  field :rank_lexicon, type: Hash, default: {}
  field :rank_nlp, type: Hash, default: {}
  field :rank_me, type: Hash, default: {}
  
end

