class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :nickname, type: String
  
  validates_presence_of :name
  validates_uniqueness_of :name, :nickname
  
  has_many :tweets
end