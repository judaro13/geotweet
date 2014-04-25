class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  
  
  field :name, type: String
  field :counter, type: Integer, default: 0
  field :lang, type: String
  
  field :rank, type: Hash, default: {}
  field :rank_ling_pipe, type: Hash, default: {}
  field :rank_lexicon, type: Hash, default: {}
  field :rank_nlp, type: Hash, default: {}
  field :rank_me, type: Hash, default: {}
  
  validates_presence_of :name
  validates_uniqueness_of :name
   
  
  def up_counter
    self.counter += 1
    self.save
  end
end

