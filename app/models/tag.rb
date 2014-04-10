class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  
  
  field :name, type: String
  field :counter, type: Integer, default: 1
  field :lang
  
  validates_presence_of :name
  validates_uniqueness_of :name
   
  
  def up_counter
    self.counter += 1
    self.save
  end
end

