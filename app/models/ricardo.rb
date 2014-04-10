class Ricardo
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :tweet_id, type: String
  field :rank_DynamicLMClassifier

end

