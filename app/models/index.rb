class Card
  include Mongoid::Document
  
  field :count, :type => Integer, :default => 0
  
end