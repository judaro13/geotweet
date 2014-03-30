class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :nickname, type: String
  
  validate_presence_of :name
  validates_uniqueness_of :name, :nickname
end